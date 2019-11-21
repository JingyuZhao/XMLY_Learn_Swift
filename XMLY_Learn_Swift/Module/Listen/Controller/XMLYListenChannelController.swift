//
//  XMLYListenChannelController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView
class XMLYListenChannelController: XMLYBaseViewController,LTTableViewProtocal {
    
    
    // - footerView
    private lazy var footerView:XMLYListenFooterView = {
        let view = XMLYListenFooterView.init(frame: CGRect(x:0, y:0, width:XMLYScreenWidth, height:100))
        view.listenFooterViewTitle = "➕添加频道"
        //            view.delegate = self
        return view
    }()
    
    private let XMLYListenChannelCellID = "XMLYListenChannelCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 5, width:XMLYScreenWidth, height: XMLYScreenHeight - 64), self, self, nil)
        tableView.register(XMLYListenChannelCell.self, forCellReuseIdentifier: XMLYListenChannelCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: XMLYListenChannelViewModel = {
        return XMLYListenChannelViewModel()
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
        // 请求数据
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

extension XMLYListenChannelController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XMLYListenChannelCell = tableView.dequeueReusableCell(withIdentifier: XMLYListenChannelCellID, for: indexPath) as! XMLYListenChannelCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        cell.channelResults = viewModel.channelResults?[indexPath.row]
        return cell
    }
}

