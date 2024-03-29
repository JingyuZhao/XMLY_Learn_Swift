//
//  XMLYHomeLiveModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import HandyJSON
struct XMLYHomeLiveRankModel : HandyJSON{
    var data: XMLYHomeLiveRankListModel?
    var ret: Int = 0
}
struct XMLYHomeLiveRankListModel: HandyJSON {
    var hpRankRollMillisecond: Int = 0
    var multidimensionalRankVos: [XMLYMultidimensionalRankVosModel]?
}

struct XMLYMultidimensionalRankVosModel: HandyJSON {
    var dimensionName: String?
    var dimensionType: Int = 0
    var htmlUrl: String?
    var ranks: [XMLYRankList]?
}

struct XMLYRankList: HandyJSON {
    var coverSmall: String?
    var nickname: String?
    var uid: Int = 0
}

/// 直播顶部banner数据模型
struct XMLYHomeLiveBanerModel: HandyJSON {
    var ret: Int = 0
    var responseId: Int = 0
    var data:[XMLYHomeLiveBanerList]?
    var adIds: [Any]?
    var adTypes: [Any]?
    var source: Int = 0
}

struct XMLYHomeLiveBanerList: HandyJSON {
    var shareData: String?
    var isShareFlag: String?
    var thirdStatUrl: String?
    var thirdShowStatUrls: [Any]?
    var thirdClickStatUrls: [Any]?
    var showTokens: [Any]?
    var clickTokens: [Any]?
    var recSrc: String?
    var recTrack: String?
    var link: String?
    var realLink: String?
    var adMark: String?
    var isLandScape: Bool = false
    var isInternal: Int = 0
    var bucketIds: String?
    var adpr: String?
    var planId: Int = 0
    var cover: String?
    var showstyle: Int = 0
    var name: String?
    var description: String?
    var scheme: String?
    var linkType: Int = 0
    var displayType: Int = 0
    var clickType: Int = 0
    var openlinkType: Int = 0
    var loadingShowTime: Int = 0
    var apkUrl: String?
    var adtype: Int = 0
    var auto: Bool = false
    var isAd: Bool = false
    var targetId: Int = 0
    var clickAction: Int = 0
    var template: String?
    var buttonText: String?
    var buttonShowed: Bool = false
    var categoryTitle: String?
    var color: String?
    var adid: Int = 0
}

/// 直播顶部分类数据模型
struct XMLYHomeLiveClassifyModel: HandyJSON {
    var data: XMLYHomeLiveClassify?
    var ret: Int = 0
}

struct XMLYHomeLiveClassify: HandyJSON {
    var materialVoList: [XMLYMaterialVoList]?
    var showed: Bool = false
}

struct XMLYMaterialVoList: HandyJSON {
    var coverPath: String?
    var id: Int = 0
    var targetUrl: String?
    var title: String?
    var type: Int = 0
}

/// 直播主播数据模型
struct XMLYHomeLiveModel: HandyJSON {
    var data:XMLYHomeLiveDataModel?
    var ret: Int = 0
}

struct XMLYHomeLiveDataModel: HandyJSON {
    var categoryVoList:[XMLYCategoryVoList]?
    var lastPage: Bool = false
    var lives:[XMLYLivesModel]?
    var pageId: Int = 0
    var pageSize: Int = 0
}

struct XMLYCategoryVoList: HandyJSON {
    var id: String?
    var name: String?
}

struct XMLYLivesModel: HandyJSON {
    var actualStartAt: Int = 0
    var avatar: String?
    var categoryId: Int = 0
    var categoryName: String?
    var chatId: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall: String?
    var id: Int = 0
    var mode: XMLYMode?
    var name: String?
    var nickname: String?
    var permissionType: Int = 0
    var playCount: Int = 0
    
    var price: Int = 0
    var roomId: Int = 0
    var status: Int = 0
    var uid: Int = 0
    var type: Int = 0
}

struct XMLYMode: HandyJSON {
    var firstColor: String?
    var modeName: String?
    var modeType: Int = 0
    var secondColor: String?
}
