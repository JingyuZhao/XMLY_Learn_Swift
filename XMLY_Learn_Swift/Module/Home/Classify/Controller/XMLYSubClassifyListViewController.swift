//
//  XMLYSubClassifyListViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class XMLYSubClassifyListViewController: XMLYBaseViewController {
    
    // - 上页面传过来请求接口必须的参数
    private var keywordId: Int = 0
    private var categoryId: Int = 0
    convenience init(keywordId: Int = 0, categoryId:Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    
    // - 定义接收的数据模型
    private var classifyVerticallist:[XMLYClassifyVerticalModel]?
    
    private let XMLYClassifySubVerticalCellID = "XMLYClassifySubVerticalCellID"
    
    // - 懒加载
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:XMLYScreenWidth - 15, height:120)
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // - 注册不同分区cell
        collection.register(XMLYClassifySubVerticalCell.self, forCellWithReuseIdentifier: XMLYClassifySubVerticalCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.top.bottom.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData(){
        // 分类二级界面其他分类接口请求
        XMLYSubClassifyAPIProvider.request(XMLYSubClassifyAPI.classifyOtherContentList(keywordId:self.keywordId,categoryId:self.categoryId)) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                // 从字符串转换为对象实例
                if let mappedObject = JSONDeserializer<XMLYClassifyVerticalModel>.deserializeModelArrayFrom(json:json["list"].description) {
                    self.classifyVerticallist = mappedObject as? [XMLYClassifyVerticalModel]
                    self.collectionView.uHead.endRefreshing()
                    self.collectionView.reloadData()
                }
            }
        }
    }
}
extension XMLYSubClassifyListViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.classifyVerticallist?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XMLYClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYClassifySubVerticalCellID, for: indexPath) as! XMLYClassifySubVerticalCell
        cell.classifyVerticalModel = self.classifyVerticallist?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let albumId = self.classifyVerticallist?[indexPath.row].albumId ?? 0
        let vc = XMLYPlayDetailViewController.init(ablumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
