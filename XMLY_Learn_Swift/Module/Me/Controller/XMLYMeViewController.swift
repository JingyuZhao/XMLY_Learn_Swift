//
//  XMLYMeViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit


class XMLYMeViewController: XMLYBaseViewController {
    private let XMLYMineMakeCellID = "XMLYMineMakeCell"
    private let XMLYMineShopCellID = "XMLYMineShopCell"
    
    private lazy var dataSource: Array = {
        return [[["icon":"钱数", "title": "分享赚钱"],
                 ["icon":"沙漏", "title": "免流量服务"]],
                [["icon":"扫一扫", "title": "扫一扫"],
                 ["icon":"月亮", "title": "夜间模式"]],
                [["icon":"意见反馈", "title": "帮助与反馈"]]]
    }()
    
    // 懒加载顶部头视图
    private lazy var headerView:XMLYMineHeaderView = {
        let view = XMLYMineHeaderView.init(frame: CGRect(x:0, y:0, width:XMLYScreenWidth, height: 300))
//        view.delegate = self
        return view
    }()
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:XMLYScreenWidth, height:XMLYScreenHeight), style: UITableView.Style.plain)
        tableView.contentInset = UIEdgeInsets(top: -CGFloat(44), left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = XMLYDownColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(XMLYMineCell.self, forCellReuseIdentifier: XMLYMineMakeCellID)
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.headerView.stopAnimationViewAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        super.wr_viewWillAppear(animated)
        self.headerView.setAnimationViewAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "我的"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.tableView)
    }
}
// - 代理
extension XMLYMeViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 || section == 2 {
            return 2
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        }else {
            return 44
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:XMLYMineCell = tableView.dequeueReusableCell(withIdentifier: XMLYMineMakeCellID, for: indexPath) as! XMLYMineCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let sectionArray = dataSource[indexPath.section-1]
            let dict: [String: String] = sectionArray[indexPath.row]
            cell.imageView?.image =  UIImage(named: dict["icon"] ?? "")
            cell.textLabel?.text = dict["title"]
            if indexPath.section == 3 && indexPath.row == 1{
                let cellSwitch = UISwitch.init()
                cell.accessoryView = cellSwitch
            }else {
                cell.accessoryType = .disclosureIndicator
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = XMLYDownColor
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = XMLYDownColor
        return headerView
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(XMLYMeTestViewController(), animated: true)
    }
    
//    // 控制向上滚动显示导航栏标题和左右按钮
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        if (offsetY > 0)
//        {
//            let alpha = offsetY / CGFloat(kNavBarBottom)
//            navBarBackgroundAlpha = alpha
//        }else{
//            navBarBackgroundAlpha = 0
//        }
//    }
}
