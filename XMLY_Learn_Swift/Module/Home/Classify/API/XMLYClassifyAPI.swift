//
//  XMLYClassifyAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

let XMLYClassifyAPI = MoyaProvider<XMLYClassifyAPIType>.init()
enum XMLYClassifyAPIType {
    case classifyList
}
extension XMLYClassifyAPIType : TargetType
{
    var baseURL: URL {
        switch self {
        case .classifyList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .classifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
        }
    }
    
    // 请求类型
    public var method: Moya.Method {
        return .get
    }
    
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .classifyList:
            return .requestPlain
        }
    }
    
    // 请求头
    public var headers: [String: String]? {
        return nil
    }
    
    
}
