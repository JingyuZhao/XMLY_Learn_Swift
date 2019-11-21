//
//  XMLYListenRecommendViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class XMLYListenRecommendViewModel: NSObject {
    var albums:[albumsModel]?
    // - 数据源更新
    typealias XMLYAddDataBlock = () ->Void
    var updataBlock:XMLYAddDataBlock?
}
// - 请求数据
extension XMLYListenRecommendViewModel {
    func refreshDataSource() {
        // 1. 获取json文件路径
        let path = Bundle.main.path(forResource: "listenRecommend", ofType: "json")
        // 2. 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        // 3. 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<albumsModel>.deserializeModelArrayFrom(json: json["data"]["albums"].description) {
            self.albums = mappedObject as? [albumsModel]
            self.updataBlock?()
        }
    }
}

extension XMLYListenRecommendViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albums?.count ?? 0
    }
}
