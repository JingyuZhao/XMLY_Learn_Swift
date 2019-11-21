//
//  XMLYVipViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYVipViewController: XMLYBaseViewController {
    
    private let XMLYHomeVIPCellID           = "XMLYHomeVIPCell"
    private let XMLYHomeVipHeaderViewID     = "XMLYHomeVipHeaderView"
    private let XMLYHomeVipFooterViewID     = "XMLYHomeVipFooterView"
    private let XMLYHomeVipBannerCellID     = "XMLYHomeVipBannerCell"
    private let XMLYHomeVipCategoriesCellID = "XMLYHomeVipCategoriesCell"
    private let XMLYHomeVipHotCellID        = "XMLYHomeVipHotCell"
    private let XMLYHomeVipEnjoyCellID      = "XMLYHomeVipEnjoyCell"
    
    private var currentTopSectionCount: Int64 = 0

    lazy var headView : UIView = {
        let view = UIView.init(frame: CGRect(x:0, y:0, width: XMLYScreenWidth, height: 30))
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    lazy var tableView : UITableView = {
           let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: XMLYScreenWidth, height:XMLYScreenHeight - XMLYNavBarHeight - 44 - XMLYTabBarHeight), style: UITableView.Style.grouped)
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = UIColor.white
           tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
           // 注册头尾视图
           tableView.register(XMLYHomeVipHeaderView.self, forHeaderFooterViewReuseIdentifier: XMLYHomeVipHeaderViewID)
           tableView.register(XMLYHomeVipFooterView.self, forHeaderFooterViewReuseIdentifier: XMLYHomeVipFooterViewID)
           // 注册分区cell
           tableView.register(XMLYHomeVIPCell.self, forCellReuseIdentifier: XMLYHomeVIPCellID)
           tableView.register(XMLYHomeVipBannerCell.self, forCellReuseIdentifier: XMLYHomeVipBannerCellID)
           tableView.register(XMLYHomeVipCategoriesCell.self, forCellReuseIdentifier: XMLYHomeVipCategoriesCellID)
           tableView.register(XMLYHomeVipHotCell.self, forCellReuseIdentifier: XMLYHomeVipHotCellID)
           tableView.register(XMLYHomeVipEnjoyCell.self, forCellReuseIdentifier: XMLYHomeVipEnjoyCellID)
           tableView.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
           return tableView
       }()
    lazy var viewModel: XMLYVIPViewModel = {
        return XMLYVIPViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        //刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.loadData()
    }
    
    
}
extension XMLYVipViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case XMLYHomeVipSectionBanner:
            let cell:XMLYHomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: XMLYHomeVipBannerCellID, for: indexPath) as! XMLYHomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
//            cell.delegate = self
            return cell
        case XMLYHomeVipSectionGrid:
            let cell:XMLYHomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: XMLYHomeVipCategoriesCellID, for: indexPath) as! XMLYHomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
//            cell.delegate = self
            return cell
        case XMLYHomeVipSectionHot:
            let cell:XMLYHomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: XMLYHomeVipHotCellID, for: indexPath) as! XMLYHomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
//            cell.delegate = self
            return cell
        case XMLYHomeVipSectionEnjoy:
            let cell:XMLYHomeVipEnjoyCell = tableView.dequeueReusableCell(withIdentifier: XMLYHomeVipEnjoyCellID, for: indexPath) as! XMLYHomeVipEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
//            cell.delegate = self
            return cell
        default:
            let cell:XMLYHomeVIPCell = tableView.dequeueReusableCell(withIdentifier: XMLYHomeVIPCellID, for: indexPath) as! XMLYHomeVIPCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = XMLYPlayDetailController(albumId: (viewModel.categoryList?[indexPath.section].list?[indexPath.row].albumId)!)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:XMLYHomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: XMLYHomeVipHeaderViewID) as! XMLYHomeVipHeaderView
        headerView.titStr = viewModel.categoryList?[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = XMLYDownColor
        return view
    }
}
