//
//  XMLYListenAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
enum XMLYListenAPIType {
    case listenSubscibeList
       case listenChannelList
       case listenMoreChannelList
}
let XMLYListenAPIProvider = MoyaProvider<XMLYListenAPIType>.init()

// 请求配置
extension XMLYListenAPIType: TargetType {
    // 服务器地址
    public var baseURL: URL {
            return URL(string: "http://mobile.ximalaya.com")!
    }
    
    // 各个请求的具体路径
    public var path: String {
        switch self {
        case .listenSubscibeList:
            return "/subscribe/v2/subscribe/comprehensive/rank"
        case .listenChannelList:
            return "/radio-station/v1/subscribe-channel/list"
        default:
            return "/subscribe/v3/subscribe/recommend"
        }
    }
    
    /// 请求方式
    public var method: Moya.Method { return .get }
    /// 请求参数
    public var task: Task {
        var parmeters = ["pageId":1] as [String : Any]
        switch self {
        case .listenSubscibeList:
             parmeters = [
                "pageSize":30,
                "pageId":1,
                "device":"iPhone",
                "sign":2,
                "size":30,
                "tsuid":124057809,
                "xt": Int32(Date().timeIntervalSince1970)
                ] as [String : Any]
        case .listenChannelList:
            break
        default:
             parmeters = [
                "pageSize":30,
                "pageId":1,
                "device":"iPhone"] as [String : Any]
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    /// 请求头
    public var headers: [String : String]? { return nil }
}
