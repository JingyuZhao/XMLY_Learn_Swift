//
//  XMLYHomeBroadcastModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import HandyJSON

struct XMLYHomeBroadcastModel : HandyJSON{
    var data:XMLYRadiosModel?
    var ret: Int = 0
}
struct XMLYRadiosModel: HandyJSON {
    var categories: [XMLYRadiosCategoriesModel]?
    var localRadios: [XMLYLocalRadiosModel]?
    var location: String?
    var radioSquareResults: [XMLYRadioSquareResultsModel]?
    var topRadios: [XMLYTopRadiosModel]?
}

struct XMLYRadiosCategoriesModel: HandyJSON{
    var id: Int = 0
    var name: String?
}

struct XMLYLocalRadiosModel :HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [XMLYRadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}

struct XMLYRadiosPlayUrlModel :HandyJSON {
    var aac24: String?
    var aac64: String?
    var ts24: String?
    var ts64: String?
}

struct XMLYRadioSquareResultsModel: HandyJSON {
    var icon: String?
    var id: Int = 0
    var title: String?
    var uri: String?
}

struct XMLYTopRadiosModel: HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [XMLYRadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}
