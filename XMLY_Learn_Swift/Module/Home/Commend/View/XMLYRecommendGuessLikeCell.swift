//
//  XMLYRecommendGuessLikeCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class XMLYRecommendGuessLikeCell: UICollectionViewCell {
    
    private var recommendList:[XMLYRecommendListModel]?
    private let XMLYGuessYouLikeCellID = "XMLYGuessYouLikeCellID"

    private lazy var changeBtn : UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.setTitleColor(XMLYButtonColor, for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(XMLYGuessLikeCell.self, forCellWithReuseIdentifier: XMLYGuessYouLikeCellID)
        return collectionView
    }()
    
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(button:UIButton){
        // 首页推荐接口请求
        XMLYHomeCommendProvider.request(.changeGuessYouLikeList) { result in
            if case let .success(response) = result {
                // 解析数据
                let data = try? response.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)
                if let mappedObject = JSONDeserializer<XMLYRecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [XMLYRecommendListModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    var recommendListData : [XMLYRecommendListModel]? {
        didSet{
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUIConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUIConfig() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
}
extension XMLYRecommendGuessLikeCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYGuessYouLikeCellID, for: indexPath) as! XMLYGuessLikeCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("选中")
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 5, left: 0, bottom: 5, right: 0)
    }
    //最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (XMLYScreenWidth - 55) / 3, height: 180)
    }
}
