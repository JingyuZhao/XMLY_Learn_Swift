//
//  XMLYListenFooterView.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYListenFooterView: UIView {
    private var addButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(addButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
        self.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    
    var listenFooterViewTitle:String?{
        didSet {
            addButton.setTitle(listenFooterViewTitle, for: UIControl.State.normal)
        }
    }
    
    @objc func addButtonClick(){

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
