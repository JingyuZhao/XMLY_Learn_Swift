//
//  XMLYHomeVipEnjoyCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYHomeVipEnjoyCell: UITableViewCell {

    private var categoryContents:[XMLYCategoryContents]?
       
       private let XMLYVipEnjoyCellID = "XMLYVipEnjoyCell"
       
       private lazy var collectionView : UICollectionView = {
           let layout = UICollectionViewFlowLayout.init()
           let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
           collectionView.delegate = self
           collectionView.dataSource = self
           collectionView.backgroundColor = UIColor.white
           collectionView.alwaysBounceVertical = true
           collectionView.register(XMLYVipEnjoyCell.self, forCellWithReuseIdentifier: XMLYVipEnjoyCellID)
           return collectionView
       }()
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           setUpLayout()
       }

       
       func setUpLayout(){
           self.addSubview(self.collectionView)
           self.collectionView.snp.makeConstraints { (make) in
               make.left.equalToSuperview().offset(15)
               make.right.equalToSuperview().offset(-15)
               make.height.equalToSuperview()
           }
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
       var categoryContentsModel:[XMLYCategoryContents]? {
           didSet {
               guard let model = categoryContentsModel else {return}
               self.categoryContents = model
               self.collectionView.reloadData()
           }
       }

}
extension XMLYHomeVipEnjoyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return self.recommendList?.count ?? 0
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XMLYVipEnjoyCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYVipEnjoyCellID, for: indexPath) as! XMLYVipEnjoyCell
        cell.categoryContentsModel = self.categoryContents?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        delegate?.homeVipEnjoyCellItemClick(model: (self.categoryContents?[indexPath.row])!)
    }
    
    // 每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    // 最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(XMLYScreenWidth - 50) / 3,height:self.frame.size.height)
    }
}
