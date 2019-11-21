//
//  XMLYFindHeaderView.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYFindHeaderView: UIView {
    
    let dataArray = ["电子书城","全民朗读","大咖主播","活动","直播微课","听单","游戏中心","边听变看","商城","0元购"]
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (XMLYScreenWidth - 30) / 5, height:90)
        let collectionView = UICollectionView.init(frame:CGRect(x:15, y:0, width:XMLYScreenWidth - 30, height:180), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(XMLYFindHeaderViewCell.self, forCellWithReuseIdentifier:"XMLYFindCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        let footerView = UIView()
        footerView.backgroundColor = XMLYDownColor
        self.addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
extension XMLYFindHeaderView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XMLYFindHeaderViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMLYFindCell", for: indexPath) as! XMLYFindHeaderViewCell
        cell.dataString = self.dataArray[indexPath.row]
        return cell
    }
}
