//
//  XMLYFindHeaderViewCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYFindHeaderViewCell: UICollectionViewCell {
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
               make.height.width.equalTo(45)
               make.centerX.equalToSuperview()
               make.top.equalToSuperview().offset(10)
           }
           
           self.addSubview(self.titleLabel)
           self.titleLabel.snp.makeConstraints { (make) in
               make.left.right.equalToSuperview()
               make.top.equalTo(self.imageView.snp.bottom).offset(10)
               make.height.equalTo(20)
           }
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
       var dataString: String? {
           didSet {
               self.titleLabel.text = dataString
               self.imageView.image = UIImage(named: dataString!)
           }
       }
}
