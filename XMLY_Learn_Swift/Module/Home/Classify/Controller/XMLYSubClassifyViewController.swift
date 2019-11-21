//
//  XMLYSubClassifyViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView

class XMLYSubClassifyViewController: XMLYBaseViewController {

    private var categoryId: Int = 0
    private var isVipPush:Bool = false
    
    private var Keywords:[XMLYClassifySubMenuKeywords]?
    private lazy var nameArray = NSMutableArray()
    private lazy var keywordIdArray = NSMutableArray()
    
    lazy var subClassifyViewModel : XMLYSubClassifyViewModel = {
        return XMLYSubClassifyViewModel()
    }()
    
    convenience init(categoryId:Int = 0,isVipPush:Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configUI() {
        setHeaderSubClassifyInfo()
    }

    func setHeaderSubClassifyInfo() {
        XMLYSubClassifyAPIProvider.request(.headerCategoryId(categoryId: self.categoryId)) { result in
            if case let .success(respone) = result {
                let data = try? respone.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)
                if let mapObject = JSONDeserializer<XMLYClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    self.Keywords = mapObject as? [XMLYClassifySubMenuKeywords]
                    for keyword in self.Keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush{
                        self.nameArray.insert("推荐", at: 0)
                    }
                    self.setupHeaderView()
                }
                
            }
        }
    }
    
    
    func setupHeaderView(){
        //创建page的样式
        let style = PageStyle.init()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = XMLYButtonColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = XMLYDownColor
         
        var viewControllers : [XMLYBaseViewController] = [XMLYBaseViewController]()
        for keyword in self.Keywords! {
            let controller = XMLYSubClassifyListViewController(keywordId:keyword.keywordId, categoryId:keyword.categoryId)
            viewControllers.append(controller)
        }
        
        if !self.isVipPush{
            // 这里需要插入推荐的控制器，因为接口数据中并不含有推荐
            let categoryId = self.Keywords?.last?.categoryId
            viewControllers.insert(XMLYSubCLassifyCommendViewController(categoryId:categoryId!), at: 0)
        }
        
        for vc in viewControllers{
            self.addChild(vc)
        }
        let pageView = PageView(frame: CGRect(x: 0, y: XMLYNavBarHeight, width: XMLYScreenWidth, height: XMLYScreenHeight - XMLYNavBarHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
        
        
    }
}
