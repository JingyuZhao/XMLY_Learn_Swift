//
//  XMLYFindAttentionController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView

class XMLYFindAttentionController : XMLYBaseViewController,LTTableViewProtocal {
    
    private let XMLYFindAttentionCellID = "XMLYFindAttentionCellID"
    
    lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:XMLYScreenWidth, height: XMLYScreenHeight - XMLYNavBarHeight - XMLYTabBarHeight), self, self, nil)
        tableView.register(XMLYFindAttentionCell.self, forCellReuseIdentifier: XMLYFindAttentionCellID)
        return tableView
    }()
    
    private var findViewModel : XMLYFindAttentionViewModel = {
        return XMLYFindAttentionViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        setupLoadData()
    }
    // 加载数据
       func setupLoadData() {
           // 加载数据
           findViewModel.updataBlock = { [unowned self] in
               // 更新列表数据
               self.tableView.reloadData()
           }
           findViewModel.refreshDataSource()
       }
    
}
extension XMLYFindAttentionController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return findViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return findViewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XMLYFindAttentionCell = tableView.dequeueReusableCell(withIdentifier: XMLYFindAttentionCellID, for: indexPath) as! XMLYFindAttentionCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.eventInfosModel = findViewModel.eventInfos?[indexPath.row]
        return cell
    }
}
