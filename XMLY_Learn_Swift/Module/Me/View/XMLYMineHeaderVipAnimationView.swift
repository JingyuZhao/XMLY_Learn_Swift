//
//  XMLYMineHeaderVipAnimationView.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYMineHeaderVipAnimationView: UIView {
    // 图片
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vip")
        return imageView
    }()
    
    //标题
    private lazy var titleLabel : UILabel = {
        let titleLabel = UILabel.init(frame: CGRect.zero)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .gray
        titleLabel.text = "VIP会员"
        return titleLabel
    }()
    
    //介绍
    private lazy var subDetialLabel : UILabel = {
        let subLabel = UILabel.init(frame: CGRect.zero)
        subLabel.textColor = .gray
        subLabel.text = "免费领取7天会员"
        subLabel.font = UIFont.systemFont(ofSize: 13)
        return subLabel
    }()
    
    //箭头
    private lazy var arrowLabel : UILabel = {
        let arrow = UILabel.init(frame: CGRect.zero)
        arrow.textColor = .gray
        arrow.text = ">"
        arrow.textColor = .gray
        return arrow
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        setUIConfig()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUIConfig() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subDetialLabel)
        self.addSubview(self.arrowLabel)
        
        self.imageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.height.width.equalTo(30)
            make.top.equalToSuperview().offset(10)

        }
        
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp_right).offset(5)
            make.height.equalTo(30)
            make.centerY.equalTo(self.imageView.snp_centerY).offset(5)
            make.right.equalToSuperview().offset(-5)
        }
        
        self.subDetialLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-5)
        }
        
        self.arrowLabel.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize.init(width: 20, height: 20))
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-5)
        }
    }
}
