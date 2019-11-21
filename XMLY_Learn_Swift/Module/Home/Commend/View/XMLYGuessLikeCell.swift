//
//  XMLYGuessLikeCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYGuessLikeCell: UICollectionViewCell {
    var recommendData : XMLYRecommendListModel? {
        didSet{
            guard let model = recommendData else { return }
            if (model.pic != nil) {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLabel.text = model.title
            self.subTitleLabel.text = model.subtitle
        }
    }
    
    private var imageView : UIImageView = {
        let imageView = UIImageView.init(frame: CGRect.zero)
        return imageView
    }()
    
    private var titleLabel : UILabel = {
        let title = UILabel.init(frame: CGRect.zero)
        title.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
        return title;
    }()
    
    private var subTitleLabel : UILabel = {
        let subtitle = UILabel.init(frame: CGRect.zero)
        subtitle.font = UIFont.systemFont(ofSize: 14)
        subtitle.textColor = UIColor.gray
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        titleLabel.snp.makeConstraints { (male) in
            male.left.right.equalToSuperview()
            male.top.equalTo(imageView.snp_bottom).offset(5)
            male.height.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp_bottom).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
