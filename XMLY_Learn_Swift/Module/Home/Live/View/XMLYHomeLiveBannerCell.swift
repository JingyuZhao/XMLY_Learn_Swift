//
//  XMLYHomeLiveBannerCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import FSPagerView
import SwiftMessages

class XMLYHomeLiveBannerCell: UICollectionViewCell {
    private var liveBanner : [XMLYHomeLiveBanerList]?
    private lazy var pagerView : FSPagerView = {
       let pagerView = FSPagerView()
       pagerView.delegate = self
       pagerView.dataSource = self
       pagerView.automaticSlidingInterval =  3
       pagerView.isInfinite = !pagerView.isInfinite
       pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "LBFMHomeLiveBannerCell")
       return pagerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var bannerList: [XMLYHomeLiveBanerList]? {
        didSet {
            guard let model = bannerList else { return }
            self.liveBanner = model
            self.pagerView.reloadData()
        }
    }

}
extension XMLYHomeLiveBannerCell : FSPagerViewDelegate, FSPagerViewDataSource{
    // - FSPagerView Delegate
       func numberOfItems(in pagerView: FSPagerView) -> Int {
           return self.liveBanner?.count ?? 0
       }
       
       func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
           let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "LBFMHomeLiveBannerCell", at: index)
           cell.imageView?.kf.setImage(with: URL(string:(self.liveBanner?[index].cover)!))
           return cell
       }
       
       func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
           let warning = MessageView.viewFromNib(layout: .cardView)
           warning.configureTheme(.warning)
           warning.configureDropShadow()
           
           warning.configureContent(title: "Warning", body: "暂时没有点击功能", iconText: "iconText")
           warning.button?.isHidden = true
           var warningConfig = SwiftMessages.defaultConfig
           warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
           SwiftMessages.show(config: warningConfig, view: warning)
       }
}
