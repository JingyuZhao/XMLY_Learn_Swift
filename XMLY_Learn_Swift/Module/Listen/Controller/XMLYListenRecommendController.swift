//
//  XMLYListenRecommendController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView
class XMLYListenRecommendController: XMLYBaseViewController,LTTableViewProtocal {

   private let XMLYListenRecommendCellID = "XMLYListenRecommendCell"
        
        private lazy var tableView: UITableView = {
            let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:XMLYScreenWidth, height: XMLYScreenHeight - XMLYTabBarHeight - XMLYNavBarHeight), self, self, nil)
            tableView.register(XMLYListenRecommendCell.self, forCellReuseIdentifier: XMLYListenRecommendCellID)
            tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
            // tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            return tableView
        }()
        
        lazy var viewModel: XMLYListenRecommendViewModel = {
            return XMLYListenRecommendViewModel()
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
            // 加载数据
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

    extension XMLYListenRecommendController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRowsInSection(section: section)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:XMLYListenRecommendCell = tableView.dequeueReusableCell(withIdentifier: XMLYListenRecommendCellID, for: indexPath) as! XMLYListenRecommendCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.albums = viewModel.albums?[indexPath.row]
            return cell
        }
    }
