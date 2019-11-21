//
//  XMLYHotAudiobookCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/6.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYHotAudiobookCell: UICollectionViewCell {
    private var recommendList:[XMLYRecommendListModel]?
    private let XMLYHotAudiobookCellID = "XMLYHotAudiobookCellID"

    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.setTitleColor(XMLYButtonColor, for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(XMLYHotAudioCell.self, forCellWithReuseIdentifier: XMLYHotAudiobookCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
    }
    
    func setUpLayout(){
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
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
    var recommendListData:[XMLYRecommendListModel]? {
           didSet{
               guard let model = recommendListData else { return }
               self.recommendList = model
               self.collectionView.reloadData()
           }
       }
}
extension XMLYHotAudiobookCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return self.recommendList?.count ?? 0
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell:XMLYHotAudioCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHotAudiobookCellID, for: indexPath) as! XMLYHotAudioCell
           cell.recommendData = self.recommendList?[indexPath.row]
           return cell
       }
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       }
    
    //每个分区的内边距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
       }
       
       //最小 item 间距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0;
       }
       
       //最小行间距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0;
       }
       
       //item 的尺寸
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize.init(width:XMLYScreenWidth - 30,height:120)
       }
}
