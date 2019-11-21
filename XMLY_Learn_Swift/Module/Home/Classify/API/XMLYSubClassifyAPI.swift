//
//  XMLYSubClassifyAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import Moya

enum XMLYSubClassifyAPI {
    // 顶部分类传参categoryId
    case headerCategoryId(categoryId: Int)
    // 推荐传参categoryId
    case classifyRecommendList(categoryId: Int)
    // 其他分类传参categoryId
    case classifyOtherContentList(keywordId: Int, categoryId: Int)
}

let XMLYSubClassifyAPIProvider = MoyaProvider<XMLYSubClassifyAPI>.init()

extension XMLYSubClassifyAPI : TargetType {
    var path: String {
         switch self {
               case .headerCategoryId:
                   return "/discovery-category/keyword/all/1534468874767"
               case .classifyRecommendList:
                   return "/discovery-category/v2/category/recommend/ts-1534469064622"
               case .classifyOtherContentList:
                   return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
               }
    }
    
    var method: Moya.Method {
         return .get
    }
    
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var parmeters = [String:Any]()
        switch self {
        case .headerCategoryId(let categoryId):
            parmeters = ["device":"iPhone","gender":9]
            parmeters["categoryId"] = categoryId
        case .classifyRecommendList(let categoryId):
            parmeters = ["appid":0,
                         "device":"iPhone",
                         "gender":9,
                         "inreview":false,
                         "network":"WIFI",
                         "operator":3,
                         "scale":3,
                         "uid":124057809,
                         "version":"6.5.3",
                         "xt": Int32(Date().timeIntervalSince1970),
                         "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            parmeters["categoryId"] = categoryId
            
        case .classifyOtherContentList(let keywordId, let categoryId):
            parmeters = ["calcDimension":"hot",
                         "device":"iPhone",
                         "pageId":1,
                         "pageSize":20,
                         "status":0,
                         "version":"6.5.3"]
            parmeters["keywordId"] = keywordId
            parmeters["categoryId"] = categoryId
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
}

