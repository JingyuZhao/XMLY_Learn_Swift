//
//  XMLYHomeViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import DNSPageView
class XMLYHomeViewController: XMLYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setSegementPage()
    }
    
    private func setSegementPage() {
        let style = PageStyle.init()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = XMLYButtonColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐","分类","VIP","直播","广播"]
        let commend =  XMLYCommendViewController.init()
        let viewControllers:[UIViewController] = [commend,XMLYClassifyViewController(),XMLYVipViewController(),XMLYLiveViewController(),XMLYBroadcastViewController()]
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = PageView.init(frame: CGRect(x: 0, y: XMLYNavBarHeight, width: XMLYScreenWidth, height: XMLYScreenHeight - XMLYNavBarHeight - 44), style: style, titles: titles, childViewControllers: viewControllers)
        pageView.contentView.backgroundColor = UIColor.red
        view.addSubview(pageView)
        
    }
}
