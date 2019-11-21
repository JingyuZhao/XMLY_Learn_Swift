//
//  XMLYClassifyViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class XMLYClassifyViewModel: NSObject {
    var classifyModel:[XMLYClassifyModel]?
    // - 数据源更新
    typealias XMLYUpdateBlock = () ->Void
    var updataBlock:XMLYUpdateBlock?
}
extension XMLYClassifyViewModel{
    func refreshDataSource() {
        // 首页分类接口请求
        XMLYClassifyAPI.request(.classifyList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<XMLYHomeClassifyModel>.deserializeFrom(json: json.description) {
                    self.classifyModel = mappedObject.list
                }
                self.updataBlock?()
            }
        }
    }
}
extension XMLYClassifyViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.classifyModel?.count ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    // 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2.5, bottom: 0, right: 2.5)
    }
    
    // 最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // 最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 2
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(XMLYScreenWidth - 10) / 4,height:40)
        }else {
            return CGSize.init(width:(XMLYScreenWidth - 7.5) / 3,height:40)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: XMLYScreenHeight, height:30)
        }
    }
    
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: XMLYScreenWidth, height: 8.0)
    }
}
