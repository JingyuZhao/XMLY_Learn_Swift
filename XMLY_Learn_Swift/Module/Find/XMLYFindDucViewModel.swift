//
//  XMLYFindDucViewModel.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
class XMLYFindDucViewModel: NSObject {
    
    var findDucList : [XMLYFindDudModel]?
    
    typealias FindDucBlock = () -> Void
    var updateBlock : FindDucBlock?
}
extension XMLYFindDucViewModel {
    func refreseData() {
        // 1. 获取json文件路径
        let path = Bundle.main.path(forResource: "FindDud", ofType: "json")
        // 2. 获取json文件里面的内容,NSData格式
        let jsonData = NSData(contentsOfFile: path!)
        // 3. 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<XMLYFMFindDudModel>.deserializeFrom(json: json.description) {
            self.findDucList = mappedObject.data
        }
        self.updateBlock?()
    }
}
extension XMLYFindDucViewModel {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.findDucList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}
