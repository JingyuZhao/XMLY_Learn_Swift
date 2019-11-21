//
//  XMLYClassifyModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import HandyJSON

struct XMLYHomeClassifyModel: HandyJSON {
    var list:[XMLYClassifyModel]?
    var msg: String?
    var code: String?
    var ret: Int = 0
}
struct XMLYClassifyModel: HandyJSON {
    var groupName: String?
    var displayStyleType: Int = 0
    var itemList:[XMLYItemList]?
}

struct XMLYItemList: HandyJSON {
    var itemType: Int = 0
    var coverPath: String?
    var isDisplayCornerMark: Bool = false
    var itemDetail: XMLYItemDetail?
}

struct XMLYItemDetail: HandyJSON {
    var categoryId: Int = 0
    var name: String?
    var title: String?
    var categoryType: Int = 0
    var moduleType: Int = 0
    var filterSupported: Bool = false
    var keywordId: Int = 0
    var keywordName: String?
}

