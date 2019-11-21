//
//  XMLYPlayDetailInfoViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView

class XMLYPlayDetailInfoViewController: XMLYBaseViewController,LTTableViewProtocal {
    
    private var playDetailAlbum:XMLYPlayDetailAlbumModel?
    private var playDetailUser:XMLYPlayDetailUserModel?
    private let XMLYPlayDetailInfoCellID = "XMLYPlayDetailInfoCellID"
    private let XMLYPlayDetailAnchorCellID = "XMLYPlayDetailAnchorCellID"
    
    private lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect.init(x: 0, y: 0, width: XMLYScreenWidth, height: XMLYScreenHeight), self, self, nil)
        tableView.register(XMLYPlayDetailInfoCell.self, forCellReuseIdentifier: XMLYPlayDetailInfoCellID)
        tableView.register(XMLYPlayDetailInfoAnchorCell.self, forCellReuseIdentifier: XMLYPlayDetailAnchorCellID)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configUI() {
        self.view.addSubview(self.tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    // 内容简介model
    var playDetailAlbumModel:XMLYPlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            self.playDetailAlbum = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableView.RowAnimation.none)
            }
        }
    }
    // 主播简介model
    var playDetailUserModel:XMLYPlayDetailUserModel? {
        didSet{
            guard let model = playDetailUserModel else {return}
            self.playDetailUser = model
            // 防止刷新分区的时候界面闪烁
            UIView.performWithoutAnimation {
                self.tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableView.RowAnimation.none)
            }
            
        }
        
    }
    
}
extension XMLYPlayDetailInfoViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell : XMLYPlayDetailInfoCell = tableView.dequeueReusableCell(withIdentifier: XMLYPlayDetailInfoCellID, for: indexPath) as! XMLYPlayDetailInfoCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailAlbumModel = self.playDetailAlbum
            return cell
        }else{
            let cell : XMLYPlayDetailInfoAnchorCell = tableView.dequeueReusableCell(withIdentifier: XMLYPlayDetailAnchorCellID, for: indexPath) as! XMLYPlayDetailInfoAnchorCell
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.playDetailUserModel = self.playDetailUser
            return cell
        }
    }
}
