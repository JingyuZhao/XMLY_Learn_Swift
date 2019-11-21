//
//  XMLYHomeVipBannerCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import FSPagerView

class XMLYHomeVipBannerCell: UITableViewCell {
    
    var vipBanner: [XMLYFocusImagesData]?
    
    // - 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "XMLYHomeVipBannerCell")
        return pagerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.pagerView.itemSize = CGSize.init(width: XMLYScreenWidth-60, height: 140)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var vipBannerList: [XMLYFocusImagesData]? {
        didSet {
            guard let model = vipBannerList else { return }
            self.vipBanner = model
            self.pagerView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension XMLYHomeVipBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    // - FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.vipBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XMLYHomeVipBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.vipBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url:String = self.vipBanner?[index].link ?? ""
//        delegate?.homeVipBannerCellClick(url: url)
        print("loadUrl:\(url)")
    }
}
