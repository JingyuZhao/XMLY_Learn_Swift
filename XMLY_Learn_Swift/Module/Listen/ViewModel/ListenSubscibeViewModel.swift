//
//  XMLYListenViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
class XMLYListenSubscibeViewModel: NSObject {
    var albumResults:[AlbumResultsModel]?
    typealias XMLYAddDataBlock = () -> Void
    var updataBlock:XMLYAddDataBlock?
}
// - 请求数据
extension XMLYListenSubscibeViewModel {
    func refreshDataSource() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenSubscibe", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<AlbumResultsModel>.deserializeModelArrayFrom(json: json["data"]["albumResults"].description) {
            self.albumResults = mappedObject as? [AlbumResultsModel]
            self.updataBlock?()
        }
    }
}

extension XMLYListenSubscibeViewModel {
    // - 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albumResults?.count ?? 0
    }
}
