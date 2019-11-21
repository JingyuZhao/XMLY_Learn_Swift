//
//  XMLYListenChannelViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class XMLYListenChannelViewModel: NSObject {
    var channelResults:[ChannelResultsModel]?
    typealias XMLYAddDataBlock = () ->Void
    // - 数据源更新
    var updataBlock:XMLYAddDataBlock?
}
// - 请求数据
extension XMLYListenChannelViewModel {
    func refreshDataSource() {
        // 一键听接口请求
        XMLYListenAPIProvider.request(.listenChannelList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description) {
                    self.channelResults = mappedObject as? [ChannelResultsModel]
                    self.updataBlock?()
                }
            }
        }
    }
}

extension XMLYListenChannelViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.channelResults?.count ?? 0
    }
}
