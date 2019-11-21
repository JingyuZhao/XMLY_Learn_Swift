//
//  XMLYPlayDetailViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class XMLYPlayDetailViewController: XMLYBaseViewController {
    
    private var albumId : Int = 0
    
    convenience init(ablumId : Int = 0) {
        self.init()
        self.albumId = ablumId
    }
    
    private var playDetailAlbum : XMLYPlayDetailAlbumModel?
    private var playDetailUser : XMLYPlayDetailUserModel?
    private var playDetailTracks : XMLYPlayDetailTracksModel?
    
    private let infoVC = XMLYPlayDetailInfoViewController.init()
    private let programVC = XMLYPlayDetailProgramViewController.init()
    private let likeVC = XMLYPlayDetailLikeViewController.init()
    private let circleVC = XMLYPlayDetailCircleViewController.init()
    
    private lazy var vcs : [XMLYBaseViewController] = {
        return [infoVC,programVC,likeVC,circleVC]
    }()
    
    private let titles : [String] = {
        return ["简介","节目","找相似","圈子"]
    }()
    
    private lazy var style : LTLayout = {
        let style = LTLayout.init()
        style.isAverage = true
        style.sliderWidth = 80
        style.titleViewBgColor = UIColor.white
        style.titleColor = UIColor(r: 178, g: 178, b: 178)
        style.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
        style.bottomLineColor = UIColor.red
        style.sliderHeight = 44
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
        return style
    }()
    
    private lazy var headerView : XMLYPlayDetailHeaderView = {
        let headerView  = XMLYPlayDetailHeaderView.init(frame: CGRect(x:0, y:0, width:XMLYScreenWidth, height:240))
        headerView.backgroundColor = .white
        let backBtn = UIButton(type: .custom)
        backBtn.setTitle("<返回", for: .normal)
        backBtn.setTitleColor(XMLYButtonColor, for: .normal)
        backBtn.frame = CGRect.init(x: 10, y: UIApplication.shared.statusBarFrame.size.height, width: 50, height: 30)
        backBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
        headerView.addSubview(backBtn)
        return headerView
    }()
    
    private lazy var advanceManager : LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let advanceManager = LTAdvancedManager.init(frame: CGRect(x: 0, y: 0, width: XMLYScreenWidth, height: XMLYScreenHeight + XMLYNavBarHeight), viewControllers: vcs, titles: titles, currentViewController: self, layout: style) {[weak self] () -> UIView in
            guard let strongSelf = self else { return UIView() }
            let headerView = strongSelf.headerView
            return headerView
        }
        
        advanceManager.delegate = self
        advanceManager.hoverY = XMLYNavBarHeight
        return advanceManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isHidenNav = true
        
        
    }
    
    override func configUI() {
        
        
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advanceManager)
        didClickTitle()
        
        loadData()
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadData() {
        XMLYPlayDetailAPIProvider.request(XMLYPlayDetailApiType.playDetailData(albumId: albumId)){result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let playDetailAlbum = JSONDeserializer<XMLYPlayDetailAlbumModel>.deserializeFrom(json: json["data"]["album"].description) {
                    self.playDetailAlbum = playDetailAlbum
                }
                // 从字符串转换为对象实例
                if let playDetailUser = JSONDeserializer<XMLYPlayDetailUserModel>.deserializeFrom(json: json["data"]["user"].description) {
                    self.playDetailUser = playDetailUser
                }
                // 从字符串转换为对象实例
                if let playDetailTracks = JSONDeserializer<XMLYPlayDetailTracksModel>.deserializeFrom(json: json["data"]["tracks"].description) {
                    self.playDetailTracks = playDetailTracks
                }
                // 传值给headerView
                self.headerView.playDetailAlbumModel = self.playDetailAlbum
                // 传值给简介界面
                self.infoVC.playDetailAlbumModel = self.playDetailAlbum
                self.infoVC.playDetailUserModel = self.playDetailUser
                // 传值给节目界面
                self.programVC.playDetailTracksModel = self.playDetailTracks
            }
        }
    }
    
    
    
}
extension XMLYPlayDetailViewController : LTAdvancedScrollViewDelegate {
    
    private func didClickTitle(){
        advanceManager.advancedDidSelectIndexHandle = {index in
            print("didSelected:\(index)")
        }
        
        //        也可以这样写
        //        advanceManager.advancedDidSelectIndexHandle = {
        //            print("didSelected:\($0)")
        //        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}
