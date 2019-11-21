//
//  Common.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import Foundation
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages


let XMLYScreenWidth = UIScreen.main.bounds.size.width
let XMLYScreenHeight = UIScreen.main.bounds.size.height

let XMLYButtonColor = UIColor(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let XMLYDownColor = UIColor.init(red: 240/255.0, green: 241/255.0, blue: 244/255.0, alpha: 1)


// iphone X
let isIphoneX = XMLYScreenHeight == 812 ? true : false
// XMLYNavBarHeight
let XMLYNavBarHeight : CGFloat = isIphoneX ? 88 : 64
// XMLYTabBarHeight
let XMLYTabBarHeight : CGFloat = isIphoneX ? 49 + 34 : 49
