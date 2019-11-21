//
//  XMLYListenSubscibeController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView
class XMLYListenSubscibeController: XMLYBaseViewController,LTTableViewProtocal {

    private lazy var footerView:XMLYListenFooterView = {
           let view = XMLYListenFooterView.init(frame: CGRect(x:0, y:0, width:XMLYScreenWidth, height:100))
           view.listenFooterViewTitle = "➕添加订阅"
           return view
       }()
       
       private let XMLYListenSubscibeCellID = "XMLYListenSubscibeCell"
       
       private lazy var tableView: UITableView = {
           let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:XMLYScreenWidth, height: XMLYScreenHeight - 64), self, self, nil)
           tableView.register(XMLYListenSubscibeCell.self, forCellReuseIdentifier: XMLYListenSubscibeCellID)
           tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
           //  tableView.separatorStyle = UITableViewCellSeparatorStyle.none
           tableView.tableFooterView = self.footerView
           return tableView
       }()
       
       lazy var viewModel: XMLYListenSubscibeViewModel = {
           return XMLYListenSubscibeViewModel()
       }()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.view.addSubview(tableView)
           glt_scrollView = tableView
           if #available(iOS 11.0, *) {
               tableView.contentInsetAdjustmentBehavior = .never
           } else {
               automaticallyAdjustsScrollViewInsets = false
           }
           
           setupLoadData()
       }
       
       func setupLoadData() {
           // 加载数据
           viewModel.updataBlock = { [unowned self] in
               // 更新列表数据
               self.tableView.reloadData()
           }
           viewModel.refreshDataSource()
       }

}
extension XMLYListenSubscibeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XMLYListenSubscibeCell = tableView.dequeueReusableCell(withIdentifier: XMLYListenSubscibeCellID, for: indexPath) as! XMLYListenSubscibeCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.albumResults = viewModel.albumResults?[indexPath.row]
        return cell
    }
}

