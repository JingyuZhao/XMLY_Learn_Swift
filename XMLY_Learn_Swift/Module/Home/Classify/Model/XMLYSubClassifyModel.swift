//
//  XMLYSubClassifyModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import HandyJSON

struct XMYLSubClassifyModel:HandyJSON {
    var msg:String?
       var ret: Int = 0
       var gender: String?
       var keywords:[XMLYClassifySubMenuKeywords]?
       var categoryInfo:XMLYClassifySubMenuCategoryInfo?
}

struct XMLYClassifySubMenuKeywords: HandyJSON {
    var categoryId: Int = 0
    var keywordId: Int = 0
    var keywordName: String?
    var keywordType: Int = 0
    var realCategoryId: Int = 0
    
}

struct XMLYClassifySubMenuCategoryInfo:HandyJSON {
    var categoryType: Int = 0
    var contentType: String?
    var filterSupported: Bool = false
    var moduleType: Int = 0
    var name: String?
    var title: String?
}

/// 分类二级界面 推荐 Model
struct XMLYClassifyCategoryContentsList: HandyJSON {
    var calcDimension: String?
    var cardClass: String?
    var categoryId:Int = 0
    var contentType: String?
    var hasMore:Bool = false
    var keywordId:Int = 0
    var keywordName: String?
    // var list:[Any]?
    var list:[XMLYClassifyVerticalModel]?
    var loopCount:Int = 0
    var moduleType:Int = 0
    var tagName: String?
    var title: String?
}

struct XMLYClassifyModuleType14Model:HandyJSON {
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare:Bool = false
    var id: Int = 0
    var isExternalUrl: Bool = false
    var properties:XMLYPropertiesModel?
    var sharePic: String?
    var subtitle: String?
    var title: String?
    var url: String?
}

struct XMLYPropertiesModel: HandyJSON {
    var isPaid: Bool = false
    var rankClusterId: Int = 0
}

struct XMLYClassifyVerticalModel:HandyJSON {
    var albumCoverUrl290: String?
    var albumId: Int = 0
    var commentsCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverSmall:String?
    var discountedPrice: Int = 0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var draft: Bool = false
    var id: Int = 0
    var intro:String?
    var isFinished: Int = 0
    var isPaid: Bool = false
    var materialType: String?
    var nickname: String?
    var playsCounts: Int = 0
    var price:CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId:Int = 0
    var priceUnit: String?
    var provider: String?
    var refundSupportType: Int = 0
    var score:CGFloat = 0.0
    var serialState: Int = 0
    var tags: String?
    var title: String?
    var trackId:Int = 0
    var trackTitle: String?
    var tracks:Int = 0
    var uid: Int = 0
    var vipFree: Bool = false
    var vipFreeType: Int = 0
    
    // 14
    var bubbleText: String?
    var contentType: String?
    var contentUpdatedAt: Int = 0
    var coverPath: String?
    var displayClass: String?
    var enableShare:Bool = false
    // var id: Int = 0
    var isExternalUrl: Bool = false
    var properties:XMLYPropertiesModel?
    var sharePic: String?
    var subtitle: String?
    // var title: String?
    var url: String?
    
    
    // 19
    // var id: Int = 0
    var list: [XMLYClassifyModuleType19List]?
    
    // 20
    // var contentType: Int = 0
    var albums: [XMLYClassifyModuleType20List]?
    var coverPathBig: String?
    var footnote: String?
    // var intro: String?
    // var nickname:String?
    var personalSignature:String?
    var smallLogo:String?
    var specialId:Int = 0
    // var title:String?
    // var uid:Int = 0
    
    
    // 4
    var coverPathSmall:String?
    
    // 16
    var name:String?
}

struct XMLYClassifyModuleType19Model: HandyJSON {
    var id: Int = 0
    var list: [XMLYClassifyModuleType19List]?
}

struct XMLYClassifyModuleType19List: HandyJSON {
    var albumId: Int = 0
    var albumTitle: String?
    var commentsCounts: Int = 0
    var coverSmall: String?
    var createdAt: Int = 0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var duration: Int = 0
    var favoritesCounts: Int = 0
    var id: Int = 0
    var isAuthorized: Bool = false
    var isFree: Bool = false
    var isPaid: Bool = false
    var origin:XMLYClassifyModuleType19Origin?
    var playPath32: String?
    var playPath64: String?
    var playsCounts: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId: Int = 0
    var sampleDuration: Int = 0
    var sharesCounts: Int = 0
    var title: String?
    var trackId: Int = 0
    var uid: Int = 0
}

struct XMLYClassifyModuleType19Origin:HandyJSON {
    var title:String?
    var coverSmall:String?
}

struct XMLYClassifyModuleType20Model: HandyJSON {
    var contentType: Int = 0
    var albums: [XMLYClassifyModuleType20List]?
    var coverPathBig: String?
    var footnote: String?
    var intro: String?
    var nickname:String?
    var personalSignature:String?
    var smallLogo:String?
    var specialId:Int = 0
    var title:String?
    var uid:Int = 0
}

struct XMLYClassifyModuleType20List: HandyJSON {
    var albumCoverUrl290:String?
    var albumId: Int = 0
    var commentsCounts: Int = 0
    var discountedPrice: CGFloat = 0.0
    var displayDiscountedPrice: String?
    var displayPrice: String?
    var id: Int = 0
    var isDraft: Bool = false
    var isPaid: Bool = false
    var intro:String?
    var isFinished: Int = 0
    var lastUptrackAt: Int = 0
    var materialType: String?
    var origin:XMLYClassifyModuleType20Origin?
    var playsCounts: Int = 0
    var price: CGFloat = 0.0
    var priceTypeEnum: Int = 0
    var priceTypeId: Int = 0
    var priceUnit: String?
    var score: Int = 0
    var serialState: Int = 0
    var title: String?
    var tracksCounts: Int = 0
}

struct XMLYClassifyModuleType20Origin: HandyJSON {
    var albumCoverUrl290: String?
    var title:String?
}
