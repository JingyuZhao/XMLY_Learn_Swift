//
//  XMLYSubCLassifyCommendViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYSubCLassifyCommendViewController: XMLYBaseViewController {

    // - 上页面传过来请求接口必须的参数
    private var categoryId: Int = 0
    convenience init(categoryId:Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
