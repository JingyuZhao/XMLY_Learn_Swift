//
//  XMLYHomeLiveViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON


let XMLYHomeLiveSectionGrid     = 0   // 分类section
let XMLYHomeLiveSectionBanner   = 1   // 滚动图片section
let XMLYHomeLiveSectionRank     = 2   // 排行榜section
let XMLYHomeLiveSectionLive     = 3   // 直播section

class XMLYHomeLiveViewModel: NSObject {
    // 外部传值请求接口
    var categoryType :Int = 0
    convenience init(categoryType: Int = 0) {
        self.init()
        self.categoryType = categoryType
    }
    var homeLiveData: XMLYHomeLiveDataModel?
    var lives:[XMLYLivesModel]?
    var categoryVoList:[XMLYCategoryVoList]?
    var homeLiveBanerList:[XMLYHomeLiveBanerList]?
    var multidimensionalRankVos: [XMLYMultidimensionalRankVosModel]?
    
    // - 数据源更新
    typealias XMLYAddDataBlock = () ->Void
    var updataBlock:XMLYAddDataBlock?
    
}
// - 请求数据
extension XMLYHomeLiveViewModel {
    func refreshDataSource() {
        loadLiveData()
    }
    
    func loadLiveData(){
        let grpup = DispatchGroup()
        grpup.enter()
        // 首页直播接口请求
        XMLYHomeLiveAPIProvider.request(.liveList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<XMLYHomeLiveModel>.deserializeFrom(json: json.description) {
                    self.lives = mappedObject.data?.lives
                    self.categoryVoList = mappedObject.data?.categoryVoList
                    //  self.collectionView.reloadData()
                    // 更新tableView数据
                    //  self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播滚动图接口请求
        XMLYHomeLiveAPIProvider.request(.liveBannerList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<XMLYHomeLiveBanerModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.homeLiveBanerList = mappedObject.data
                    // let index: IndexPath = IndexPath.init(row: 0, section: 1)
                    // self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    // self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.enter()
        // 首页直播排行榜接口请求
        XMLYHomeLiveAPIProvider.request(.liveRankList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<XMLYHomeLiveRankModel>.deserializeFrom(json: json.description) {
                    self.multidimensionalRankVos = mappedObject.data?.multidimensionalRankVos
                    //  let index: IndexPath = IndexPath.init(row: 0, section: 2)
                    //  self.collectionView.reloadItems(at: [index])
                    // 更新tableView数据
                    //  self.updataBlock?()
                    grpup.leave()
                }
            }
        }
        
        grpup.notify(queue: DispatchQueue.main) {
            self.updataBlock?()
        }
    }
}
// - 点击分类刷新主页数据请求数据
extension XMLYHomeLiveViewModel {
    func refreshCategoryLiveData() {
        loadCategoryLiveData()
    }
    func loadCategoryLiveData(){
        XMLYHomeLiveAPIProvider.request(.categoryTypeList(categoryType:self.categoryType)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<XMLYLivesModel>.deserializeModelArrayFrom(json: json["data"]["lives"].description) {
                    self.lives = mappedObject as? [XMLYLivesModel]
                }
                self.updataBlock?()
            }
        }
    }
}
// - collectionview数据
extension XMLYHomeLiveViewModel {
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == XMLYHomeLiveSectionLive {
            return self.lives?.count ?? 0
        }else {
            return 1
        }
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 5
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 10
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case XMLYHomeLiveSectionGrid:
            return CGSize.init(width:XMLYScreenWidth - 30,height:90)
        case XMLYHomeLiveSectionBanner:
            return CGSize.init(width:XMLYScreenWidth - 30,height:110)
        case XMLYHomeLiveSectionRank:
            return CGSize.init(width:XMLYScreenWidth - 30,height:70)
        default:
            return CGSize.init(width:(XMLYScreenWidth - 40)/2,height:230)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == XMLYHomeLiveSectionLive{
            return CGSize.init(width: XMLYScreenWidth, height: 40)
        }else {
            return .zero
        }
    }
}
