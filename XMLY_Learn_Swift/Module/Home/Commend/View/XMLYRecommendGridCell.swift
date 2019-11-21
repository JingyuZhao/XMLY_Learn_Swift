//
//  XMLYRecommendGridCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYRecommendGridCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(self.imageView.snp.bottom).offset(5)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var square:XMLYSquareModel? {
        didSet{
            guard let model = square else { return }
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            self.titleLabel.text = model.title
        }
    }
    
}
