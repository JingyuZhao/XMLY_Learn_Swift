//
//  XMLYVIPInfoAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
enum XMLYVIPInfoAPIType {
    case homeVipList
}
let XMLYVIPInfoAPIProvider = MoyaProvider<XMLYVIPInfoAPIType>.init()

extension XMLYVIPInfoAPIType : TargetType{
    var baseURL: URL {
        switch self {
        case .homeVipList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .homeVipList:
            return "/product/v4/category/recommends/ts-1532592638951"
        }
    }
    
    public var method: Moya.Method { return .get }
    
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        let parmeters = [
            "appid":0,
            "categoryId":33,
            "contentType":"album",
            "inreview":false,
            "network":"WIFI",
            "operator":3,
            "scale":3,
            "uid":0,
            "device":"iPhone",
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

