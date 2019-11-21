//
//  XMLYPlayDetailInfoCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYPlayDetailInfoCell: UITableViewCell {

    private lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "内容简介"
        return label
    }()
    // 内容详情
    private lazy var subLabel:XMLYCustomLabel = {
        let label = XMLYCustomLabel()
        label.numberOfLines = 0
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpUI(){
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.right.equalToSuperview()
            make.height.equalTo(30)
        }
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.bottom.right.equalToSuperview().offset(-15)
        }
    }
    
    
    var playDetailAlbumModel:XMLYPlayDetailAlbumModel? {
           didSet{
               guard let model = playDetailAlbumModel else {return}
               self.subLabel.text = model.shortIntro
           }
       }
}
