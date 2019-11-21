//
//  XMLYVIPViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

let XMLYHomeVipSectionBanner    = 0   // 滚动图片section
let XMLYHomeVipSectionGrid      = 1   // 分类section
let XMLYHomeVipSectionHot       = 2   // 热section
let XMLYHomeVipSectionEnjoy     = 3   // 尊享section
let XMLYHomeVipSectionVip       = 4   // vip section

class XMLYVIPViewModel: NSObject {
    var homeVipData : XMLYVIPModel?
    var focusImages: [XMLYFocusImagesData]?
    var categoryList:[XMLYCategoryList]?
    var categoryBtnList: [XMLYCategoryBtnModel]?
    // Mark: -数据源更新
    typealias XMLYAddDataBlock = () ->Void
    var updataBlock:XMLYAddDataBlock?
    
}
extension XMLYVIPViewModel {
    func loadData() {
        XMLYVIPInfoAPIProvider.request(.homeVipList) { (result) in
            if case let .success(respone) = result {
                let data = try? respone.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)
                
                if let mapObject = JSONDeserializer<XMLYVIPModel>.deserializeFrom(json: json.description) {
                    self.homeVipData = mapObject
                    self.focusImages = mapObject.focusImages?.data
                    self.categoryList = mapObject.categoryContents?.list
                }
                if let categorybtn = JSONDeserializer<XMLYCategoryBtnModel>.deserializeModelArrayFrom(json:json["categoryContents"]["list"][0]["list"].description){
                    self.categoryBtnList = categorybtn as? [XMLYCategoryBtnModel]
                }
                self.updataBlock?()
                
            }
        }
    }
}
extension XMLYVIPViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        switch section {
        case XMLYHomeVipSectionVip:
            return self.categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case XMLYHomeVipSectionBanner:
            return 150
        case XMLYHomeVipSectionGrid:
            return 80
        case XMLYHomeVipSectionHot:
            return 190
        case XMLYHomeVipSectionEnjoy:
            return 230
        default:
            return 120
        }
    }
    
    // header高度
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == XMLYHomeVipSectionBanner || section == XMLYHomeVipSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    // footer 高度
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == XMLYHomeVipSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
}
