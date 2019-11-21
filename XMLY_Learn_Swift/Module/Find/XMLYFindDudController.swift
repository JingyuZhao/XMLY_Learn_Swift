//
//  XMLYFindDudController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView

class XMLYFindDudController: XMLYBaseViewController,LTTableViewProtocal {
    
    private let XMLYFindDucCellID = "XMLYFindDucCellID"
    
    private lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:XMLYScreenWidth, height: XMLYScreenHeight - XMLYNavBarHeight - XMLYTabBarHeight), self, self, nil)
        tableView.register(UINib.init(nibName: "XMLYFindDucCell", bundle: nil), forCellReuseIdentifier: XMLYFindDucCellID)
        return tableView
    }()
    
    private lazy var findDucViewModel : XMLYFindDucViewModel = {
        return XMLYFindDucViewModel()
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
        self.findDucViewModel.updateBlock = {[unowned self] in
            self.tableView.reloadData()
        }
        self.findDucViewModel.refreseData()
    }
    
}
extension XMLYFindDudController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.findDucViewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.findDucViewModel.tableView(tableView, heightForRowAt: indexPath)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:XMLYFindDucCell = tableView.dequeueReusableCell(withIdentifier: XMLYFindDucCellID, for: indexPath) as! XMLYFindDucCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.findDucModel = findDucViewModel.findDucList?[indexPath.row]
        return cell
    }
}
