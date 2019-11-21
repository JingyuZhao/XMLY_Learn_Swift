//
//  XMLYNavigationController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYNavigationController: UINavigationController {

    private weak var popDelegate:AnyObject?
    private var interactivePopTransition : UIPercentDrivenInteractiveTransition?
    private var popRecognizer : UIScreenEdgePanGestureRecognizer?
    var isSystemSlidBack = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
        
        self.popRecognizer = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(handleGesture(gesture:)))
        self.popRecognizer?.edges = UIRectEdge.left
        self.popRecognizer?.isEnabled = false
        self.view.addGestureRecognizer(self.popRecognizer!)
        //下面是全屏返回
           //        _popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleNavigationTransition:)];
//           _popRecognizer.edges = UIRectEdgeLeft;
//           [_popRecognizer setEnabled:NO];
//           [self.view addGestureRecognizer:_popRecognizer];
        setNavApprence()
    }
    
    func setNavApprence(){
        let navApprence = UINavigationBar.appearance()
        navApprence.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(red: 34/255.0, green: 45/255.0, blue: 56/255.0, alpha: 1),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)]
        navApprence.shadowImage = UIImage.init(named: " ")
        navApprence.tintColor = XMLYButtonColor
    }
    
    @objc func handleGesture(gesture:UIScreenEdgePanGestureRecognizer) {
        
    }

}
extension XMLYNavigationController : UINavigationControllerDelegate,UIGestureRecognizerDelegate{
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = self.isSystemSlidBack;
        self.popRecognizer?.isEnabled = !self.isSystemSlidBack;
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
        let frame : CGRect? = self.tabBarController?.tabBar.frame
        guard var newFram = frame else { return }
        newFram.origin.y = UIScreen.main.bounds.size.height - newFram.size.height
        self.tabBarController?.tabBar.frame = newFram
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: XMLYBaseViewController.self) {
            let vc = viewController as! XMLYBaseViewController
            if vc.isHidenNav {
                vc.navigationController?.setNavigationBarHidden(true, animated: animated)
            }else{
                vc.navigationController?.setNavigationBarHidden(false, animated: animated)
            }
            
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if (!(self.interactivePopTransition != nil)) { return nil; }
        return self.interactivePopTransition;
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.children.count != 1;
    }
}
