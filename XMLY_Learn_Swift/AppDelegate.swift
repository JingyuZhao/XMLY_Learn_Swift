//
//  AppDelegate.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 zhaojingyu. All rights reserved.
//

import UIKit
import ESTabBarController_swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = configTabBar(delegate: self as? UITabBarControllerDelegate)
        self.window?.makeKeyAndVisible()
        return true
    }

    
    func configTabBar(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tab = ESTabBarController.init()
        tab.delegate = delegate
        tab.title = "喜马拉雅"
        tab.tabBar.shadowImage = UIImage.init(named: "transparent")
        tab.shouldHijackHandler = {(tabController,viewVC,index) in
            if index==2 {
                return true
            }
            return false
        }
        
        tab.didHijackHandler = {(tabController,viewVC,index) in
            print("did click:\(index)")
        }
        
        let home = XMLYHomeViewController.init()
        let listen = XMLYListenViewController.init()
        let play = XMLYPlayViewController.init()
        let find = XMLYFindViewController.init()
        let me = XMLYMeViewController.init()
        
        home.tabBarItem = ESTabBarItem.init(XMLYIrregularityBasicContentView.init(), title: "首页", image: UIImage.init(named: "home"), selectedImage: UIImage.init(named: "home_1"), tag: 0)
        listen.tabBarItem = ESTabBarItem.init(XMLYIrregularityBasicContentView.init(), title: "我听", image: UIImage.init(named: "find"), selectedImage: UIImage.init(named: "find_1"), tag: 1)
        play.tabBarItem = ESTabBarItem.init(XMLYIrregularityContentView.init(), title: nil, image: UIImage.init(named: "tab_play"), selectedImage: UIImage.init(named: "tab_play"), tag: 2)
        find.tabBarItem = ESTabBarItem.init(XMLYIrregularityBasicContentView.init(), title: "发现", image: UIImage.init(named: "favor"), selectedImage: UIImage.init(named: "favor_1"), tag: 3)
        me.tabBarItem = ESTabBarItem.init(XMLYIrregularityBasicContentView.init(), title: "我的", image: UIImage.init(named: "me"), selectedImage: UIImage.init(named: "me_1"), tag: 4)
        
        let homeNav = XMLYNavigationController.init(rootViewController: home)
        let listenNav = XMLYNavigationController.init(rootViewController: listen)
        let playNav = XMLYNavigationController.init(rootViewController: play)
        let findNav = XMLYNavigationController.init(rootViewController: find)
        let meNav = XMLYNavigationController.init(rootViewController: me)

        home.navigationItem.title = "首页"
        listen.navigationItem.title = "我听"
        play.navigationItem.title = "播放"
        find.navigationItem.title = "发现"
        me.navigationItem.title = "我的"
        
        tab.viewControllers = [homeNav,listenNav,playNav,findNav,meNav]
        
        return tab
    }
}

