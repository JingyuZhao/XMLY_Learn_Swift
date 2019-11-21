//
//  XMLYCommendViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class XMLYCommendViewModel: NSObject {

    var homeCommendModel : XMLYHomeRecommendModel?
    var homeCommendList : [XMLYRecommendModel]?
    var commendList : [XMLYRecommendListModel]?
    var focus : XMLYFocusModel?
    var squareList : [XMLYSquareModel]?
    var topBuzzList : [XMLYTopBuzzModel]?
    var guessYouLikeList : [XMLYGuessYouLikeModel]?
    var paidCategoryList : [XMLYPaidCategoryModel]?
    var playlist : [XMLYPlaylistModel]?
    var oneKeyListenList : [XMLYOneKeyListenModel]?
    var liveList : [XMLYLiveModel]?
    
    typealias UpdateData = ()->Void
    var updateData : UpdateData?
}
extension XMLYCommendViewModel {
    func refreshDataScoure() {
        XMLYHomeCommendProvider.request(XMLYHomeCommendAPIType.recommendList) { result in
            if case let .success(respone) = result {
                //解析数据
                let data = try? respone.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)

                if let mapJsonObject = JSONDeserializer<XMLYHomeRecommendModel>.deserializeFrom(json: json.description) {
                    self.homeCommendModel = mapJsonObject
                    self.homeCommendList = mapJsonObject.list
                    if let recommendList = JSONDeserializer<XMLYRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.commendList = recommendList as? [XMLYRecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<XMLYFocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<XMLYSquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [XMLYSquareModel]
                    }
                    if let topBuzz = JSONDeserializer<XMLYTopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [XMLYTopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<XMLYOneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [XMLYOneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<XMLYLiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [XMLYLiveModel]
                    }
                    self.updateData?()
                }
                
            }else if case .failure = result {
                print("result error:\(String(describing: result.error?.errorDescription))")
            }
        }
    }
}
extension XMLYCommendViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
            return (self.homeCommendList?.count) ?? 0
        }
        // 每个分区显示item数量
        func numberOfItemsIn(section: NSInteger) -> NSInteger {
            return 1
        }
        //每个分区的内边距
        func insetForSectionAt(section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        //最小 item 间距
        func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
            return 0
        }
        
        //最小行间距
        func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
            return 0
        }
        
        // item 尺寸
        func sizeForItemAt(indexPath: IndexPath) -> CGSize {
            let HeaderAndFooterHeight:Int = 90
            let itemNums = (self.homeCommendList?[indexPath.section].list?.count)!/3
            let count = self.homeCommendList?[indexPath.section].list?.count
            let moduleType = self.homeCommendList?[indexPath.section].moduleType
            if moduleType == "focus" {
                return CGSize.init(width:XMLYScreenWidth,height:360)
            }else if moduleType == "square" || moduleType == "topBuzz" {
                return CGSize.zero
            }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
                return CGSize.init(width:XMLYScreenWidth,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
            }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
                return CGSize.init(width:XMLYScreenWidth,height:CGFloat(HeaderAndFooterHeight+120*count!))
            }else if moduleType == "ad" {
                return CGSize.init(width:XMLYScreenWidth,height:240)
            }else if moduleType == "oneKeyListen" {
                return CGSize.init(width:XMLYScreenWidth,height:180)
            }else {
                return .zero
            }
        }
        
        // 分区头视图size
        func referenceSizeForHeaderInSection(section: Int) -> CGSize {
            let moduleType = self.homeCommendList?[section].moduleType
            if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
                return CGSize.zero
            }else {
                return CGSize.init(width: XMLYScreenHeight, height:40)
            }
        }
        
        // 分区尾视图size
        func referenceSizeForFooterInSection(section: Int) -> CGSize {
            let moduleType = self.homeCommendList?[section].moduleType
            if moduleType == "focus" || moduleType == "square" {
                return CGSize.zero
            }else {
                return CGSize.init(width: XMLYScreenWidth, height: 10.0)
            }
        }
}
