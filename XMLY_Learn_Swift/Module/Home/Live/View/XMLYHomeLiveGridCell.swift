//
//  XMLYHomeLiveGridCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYHomeLiveGridCell: UICollectionViewCell {
    private let XMLYLiveHeaderGridCellID = "XMLYLiveHeaderGridCell"
    let imageArray = [
        "http://fdfs.xmcdn.com/group45/M08/74/91/wKgKlFtVs-iBg01bAAAmze4KwRQ177.png",
        "http://fdfs.xmcdn.com/group48/M0B/D9/96/wKgKlVtVs9-TQYseAAAsVyb1apo685.png",
        "http://fdfs.xmcdn.com/group48/M0B/D9/92/wKgKlVtVs9SwvFI6AAAdwAr5vEE640.png",
        "http://fdfs.xmcdn.com/group48/M02/63/E3/wKgKnFtW37mR9fH7AAAcl17u2wA113.png",
        "http://fdfs.xmcdn.com/group46/M09/8A/98/wKgKlltVs3-gubjFAAAxXboXKFE462.png"
    ]
    
    let titleArray = ["温暖男声","心动女神","唱将达人","情感治愈","直播圈子"]
    // - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (XMLYScreenWidth - 30)/5, height:90)
        let collectionView = UICollectionView.init(frame:CGRect(x:0, y:0, width:XMLYScreenWidth - 30, height:90), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(XMLYLiveHeaderGridCell.self, forCellWithReuseIdentifier:XMLYLiveHeaderGridCellID)

        return collectionView
    }()
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           self.addSubview(self.collectionView)
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
}
extension XMLYHomeLiveGridCell : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 5
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               let cell:XMLYLiveHeaderGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYLiveHeaderGridCellID, for: indexPath) as! XMLYLiveHeaderGridCell
           cell.backgroundColor = UIColor.white
           cell.imageUrl = self.imageArray[indexPath.row]
           cell.titleString = self.titleArray[indexPath.row]
           return cell
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           delegate?.homeLiveGridCellItemClick(channelId: indexPath.row + 5,title:self.titleArray[indexPath.row])
       }
}
