//
//  XMLYPlayDetailAPI.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

enum XMLYPlayDetailApiType {
    case playDetailData(albumId:Int)//播放页数据
    case playDetailLikeList(albumId: Int) // 播放页找相似
    case playDetailCircleList // 播放页圈子
}
let XMLYPlayDetailAPIProvider = MoyaProvider<XMLYPlayDetailApiType>()
extension XMLYPlayDetailApiType : TargetType {
    // 服务器地址
    public var baseURL: URL {
        switch self {
        case .playDetailData:
            return URL(string: "http://mobile.ximalaya.com")!
        case .playDetailLikeList:
            return URL(string: "http://ar.ximalaya.com")!
        case .playDetailCircleList:
            return URL(string: "http://m.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .playDetailData: return "/mobile/v1/album/ts-1534832680180"
        case .playDetailLikeList: return "/rec-association/recommend/album/by_album"
        case .playDetailCircleList: return "/community/v1/communities/9"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .playDetailData(let albumId):
            parmeters = [
                "device":"iPhone",
                "isAsc":false,
                "isQueryInvitationBrand":false,
                "pageSize":20,
                "source":4,
                "ac":"WIFI"]
            parmeters["albumId"] = albumId
        case .playDetailLikeList(let albumId):
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            parmeters["albumId"] = albumId
        case .playDetailCircleList:
            parmeters = [
                "orderBy":1,
                "type":1
            ]
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}
