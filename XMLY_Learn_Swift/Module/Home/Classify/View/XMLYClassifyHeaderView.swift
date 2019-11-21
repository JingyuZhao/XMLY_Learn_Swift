//
//  XMLYClassifyHeaderView.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYClassifyHeaderView: UICollectionReusableView {
    private lazy var view : UIView = {
        let view = UIView()
        view.backgroundColor = XMLYButtonColor
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = XMLYDownColor
        self.addSubview(self.view)
        self.view.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.width.equalTo(4)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.right).offset(10)
            make.right.equalTo(-10)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleString: String? {
        didSet{
            guard let str = titleString else { return }
            self.titleLabel.text = str
        }
    }
}
