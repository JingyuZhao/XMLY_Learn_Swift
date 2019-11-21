//
//  XMLYFindModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import HandyJSON
/// 关注动态 Model
struct XMLYEventInfosModel: HandyJSON {
    var authorInfo:XMLYAttentionAuthorInfo?
    var contentInfo: XMLYFindAContentInfo?
    var eventTime: NSInteger = 0
    var id: NSInteger = 0
    var isFromRepost: Bool = false
    var isPraise: Bool = false
    var statInfo: XMLYFindAStatInfo?
    var timeline: NSInteger = 0
    var type: Int = 0
}

struct XMLYAttentionAuthorInfo: HandyJSON {
    var anchorGrade:Int = 0
    var avatarUrl: String?
    var isV: Bool = false
    var isVip: Bool = false
    var nickname: String?
    var uid: NSInteger = 0
    var userGrade: Int = 0
    var verifyType: Int = 0
}

struct XMLYFindAContentInfo: HandyJSON {
    var picInfos: [XMLYFindAPicInfos]?
    var text:String?
}

struct XMLYFindAPicInfos: HandyJSON {
    var id: NSInteger = 0
    var originUrl: String?
    var rectangleUrl:String?
    var squareUrl: String?
}

struct XMLYFindAStatInfo: HandyJSON {
    var commentCount: Int = 0
    var praiseCount: Int = 0
    var repostCount: Int = 0
}

/// 推荐动态 Model
struct XMLYFindRecommendModel: HandyJSON {
    var emptyTip: String?
    var endScore: Int = 0
    var hasMore: Bool = false
    var pullTip: String?
    var startScore: Int = 0
    var streamList: [XMLYFindRStreamList]?
}

struct XMLYFindRStreamList: HandyJSON {
    var avatar: String?
    var commentsCount: Int = 0
    var content: String?
    var id: Int = 0
    var issuedTs: Int = 0
    var liked: Bool = false
    var likesCount: Int = 0
    var nickname: String?
    var picUrls: [XMLYFindRPicUrls]?
    var recSrc: String?
    var recTrack: String?
    var score: Int = 0
    var subType: Bool = false
    var type: String?
    var uid : Int = 0
}
struct XMLYFindRPicUrls: HandyJSON {
    var originUrl: String?
    var thumbnailUrl: String?
}


/// 趣配音 Model
struct XMLYFMFindDudModel: HandyJSON {
    var data:[XMLYFindDudModel]?
}

struct XMLYFindDudModel: HandyJSON {
    var dubbingItem: XMLYFindDuddubbingItem?
    var feedItem: XMLYFindDudfeedItem?
}

struct XMLYFindDuddubbingItem: HandyJSON {
    var commentCount: Int = 0
    var coverLarge: String?
    var coverMiddle: String?
    var coverPath: String?
    var coverSmall: String?
    var createAt: NSInteger = 0
    var duration: Int = 0
    var favorites: Int = 0
    var intro: String?
    var logoPic: String?
    var mediaType: String?
    var nickname: String?
    var playPathAacv164: String?
    var playPathAacv224: String?
    var relatedId: Int = 0
    var title: String?
    var topicId: Int = 0
    var topicTitle: String?
    var topicUrl: String?
    var trackId: Int = 0
    var uid: Int = 0
    var updatedAt: Int = 0
}

struct XMLYFindDudfeedItem: HandyJSON {
    var contentId: Int = 0
    var contentType: String?
    var recReason: String?
    var recSrc: String?
    var recTrack: String?
}







