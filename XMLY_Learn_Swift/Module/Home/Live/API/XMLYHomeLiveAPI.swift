//
//  XMLYHomeLiveAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
enum XMLYHomeLiveAPIType {
    case liveClassifyList
    case liveBannerList
    case liveRankList
    case liveList
    case categoryLiveList(channelId:Int)
    case categoryTypeList(categoryType:Int)
}
let XMLYHomeLiveAPIProvider = MoyaProvider<XMLYHomeLiveAPIType>.init()

extension XMLYHomeLiveAPIType : TargetType {
    var baseURL: URL {
        switch self {
        case .liveBannerList:
            return URL(string: "http://adse.ximalaya.com")!
        case .categoryLiveList:
            return URL(string: "http://mobwsa.ximalaya.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .liveClassifyList:
            return "/lamia/v1/homepage/materials HTTP/1.1"
        case .liveRankList:
            return "/lamia/v2/live/rank_list"
        case .liveList:
            return "/lamia/v8/live/homepage"
        case .categoryLiveList:
            return "/lamia/v4/live/subchannel/homepage"
        case .categoryTypeList:
            return "/lamia/v9/live/homepage"
        default:
            return "/focusPicture/ts-1532427241140"
        }
    }
    
    var method: Moya.Method { return .get }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .categoryLiveList(let channelId):
            var parmeters = [
                "appid":0,
                "pageSize":40,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "pageId":1,
                "device":"iPhone",
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)] as [String : Any]
            parmeters["channelId"] = channelId
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .categoryTypeList(let categoryType):
            var parmeters = [
                "pageId":1,
                "pageSize":20,
                "sign":1,
                "timeToPreventCaching": Int32(Date().timeIntervalSince1970)] as [String : Any]
            parmeters["categoryType"] = categoryType
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        default:
            let parmeters = [
                "appid":0,
                "categoryId":-3,
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
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}

