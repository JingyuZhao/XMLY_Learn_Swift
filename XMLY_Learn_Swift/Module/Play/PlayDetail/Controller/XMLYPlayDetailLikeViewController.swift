//
//  XMLYPlayDetailLikeViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView
import Moya
import HandyJSON
import SwiftyJSON

class XMLYPlayDetailLikeViewController : XMLYBaseViewController,LTTableViewProtocal {
    
    private let XMLYPLayDetailLikeCellID : String = "XMLYPLayDetailLikeCellID"
    private var albumResults : [XMLYClassifyVerticalModel]?
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:XMLYScreenWidth, height: XMLYScreenHeight), self, self, nil)
        tableView.register(XMLYPlayDetailLikeCell.self, forCellReuseIdentifier: XMLYPLayDetailLikeCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configUI() {
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        // 刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        XMLYPlayDetailAPIProvider.request(XMLYPlayDetailApiType.playDetailLikeList(albumId: 12825974)){resule in
            if case let .success(response) = resule {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<XMLYClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.albumResults = mappedObject as? [XMLYClassifyVerticalModel]
                    self.tableView.uHead.endRefreshing()
                    self.tableView.reloadData()
                    
                }
            }
        }
    }
}
extension XMLYPlayDetailLikeViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumResults?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : XMLYPlayDetailLikeCell = tableView.dequeueReusableCell(withIdentifier: XMLYPLayDetailLikeCellID, for: indexPath) as! XMLYPlayDetailLikeCell
        cell.classifyVerticalModel = self.albumResults?[indexPath.row]
        return cell
    }
}
