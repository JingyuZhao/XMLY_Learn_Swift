
//
//  XMLYHomeBroadcastAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
enum XMLYHomeBroadcastApiType {
    case homeBroadcastList
    case categoryBroadcastList(path:String)
    case moreCategoryBroadcastList(categoryId:Int)
}

let XMLYHomeBroadcastAPIProvider = MoyaProvider<XMLYHomeBroadcastApiType>.init()

extension XMLYHomeBroadcastApiType : TargetType {
    var baseURL: URL {
        return URL(string: "http://live.ximalaya.com")!
        
    }
    
    var path: String {
        switch self {
        case .homeBroadcastList:
            return "/live-web/v5/homepage"
        case .categoryBroadcastList(let path):
            return path
        case .moreCategoryBroadcastList:
            return "/live-web/v2/radio/category"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .homeBroadcastList:
            return .requestPlain
        case .categoryBroadcastList:
            let parmeters = [
                "device":"iPhone",
                "pageNum":1,
                "pageSize":30,
                "provinceCode":"310000"] as [String : Any]
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .moreCategoryBroadcastList(let categoryId):
            var parmeters = [
                "device":"iPhone",
                "pageNum":1,
                "pageSize":30] as [String : Any]
            parmeters["categoryId"] = categoryId
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        }
    }
    
    // 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求头
    public var headers: [String: String]? {
        return nil
    }
    // 是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    
}

