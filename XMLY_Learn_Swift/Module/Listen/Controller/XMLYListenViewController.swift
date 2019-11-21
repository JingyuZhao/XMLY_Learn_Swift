//
//  XMLYListenViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView

class XMLYListenViewController: XMLYBaseViewController,LTAdvancedScrollViewDelegate {

    // 头部 - headerView
     private lazy var headerView:XMLYListenHeaderView = {
         let view = XMLYListenHeaderView.init(frame: CGRect(x:0, y:0, width:XMLYScreenWidth, height:120))
         return view
     }()
    
    // 添加l控制器上部标题
    private lazy var titles: [String] = {
        return ["订阅", "一键听", "推荐"]
    }()
    
    private lazy var layout: LTLayout = {
           let layout = LTLayout()
           layout.isAverage = true
           layout.sliderWidth = 80
           layout.titleViewBgColor = UIColor.white
           layout.titleColor = UIColor(r: 178, g: 178, b: 178)
           layout.titleSelectColor = UIColor(r: 16, g: 16, b: 16)
           layout.bottomLineColor = UIColor.red
           layout.sliderHeight = 44
           /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
           return layout
       }()
    
    // 添加控制器
       private lazy var viewControllers: [XMLYBaseViewController] = {
           let listenSubscibeVC = XMLYListenSubscibeController()
           let listenChannelVC = XMLYListenChannelController()
           let listenRecommendVC = XMLYListenRecommendController()
           return [listenSubscibeVC, listenChannelVC, listenRecommendVC]
       }()
    
       private lazy var advancedManager: LTAdvancedManager = {
           let statusBarH = UIApplication.shared.statusBarFrame.size.height
           let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: XMLYNavBarHeight, width: XMLYScreenWidth, height: XMLYScreenHeight - XMLYNavBarHeight), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
               guard let strongSelf = self else { return UIView() }
               let headerView = strongSelf.headerView
               return headerView
           })
           /* 设置代理 监听滚动 */
           advancedManager.delegate = self
           /* 设置悬停位置 */
           // advancedManager.hoverY = - XMLYNavBarHeight
           /* 点击切换滚动过程动画 */
           // advancedManager.isClickScrollAnimation = true
           /* 代码设置滚动到第几个位置 */
           // advancedManager.scrollToIndex(index: viewControllers.count - 1)
           return advancedManager
       }()
       
    override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = UIColor.white

           // 导航栏左右item
           self.automaticallyAdjustsScrollViewInsets = false
           view.addSubview(advancedManager)
           advancedManagerConfig()
       }

       deinit {
           print(" --- deinit --- ")
       }
    
    // 具体使用请参考以下
    private func advancedManagerConfig() {
        // 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("选中了 -> \($0)")
        }
    }
    
    func glt_scrollViewOffsetY(_ offsetY: CGFloat) {
        
    }
}
