//
//  XMLYPlayDetailPlayerViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYPlayDetailPlayerViewController: XMLYBaseViewController {
    
    // 外部传值请求接口
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    // - 导航栏左边按钮
    private lazy var leftBarButton:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    // - 导航栏左边消息点击事件
    @objc func leftBarButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func configUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
