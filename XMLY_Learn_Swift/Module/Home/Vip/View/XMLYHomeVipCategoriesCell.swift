//
//  XMLYHomeVipCategoriesCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/7.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYHomeVipCategoriesCell: UITableViewCell {

    private var categoryBtnList:[XMLYCategoryBtnModel]?

    // MARK: - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:XMLYScreenWidth / 5, height:80)
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.contentSize = CGSize.init(width: XMLYScreenWidth, height: 80)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(XMLYVipCategoryCell.self, forCellWithReuseIdentifier:"XMLYVipCategoryCell")
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: .default, reuseIdentifier: reuseIdentifier)
           self.addSubview(self.collectionView)
           self.collectionView.snp.makeConstraints { (make) in
               make.left.right.height.width.equalToSuperview()
           }
       }
       
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
    var categoryBtnModel : [XMLYCategoryBtnModel]? {
        didSet {
            guard let model = categoryBtnModel else {return}
            self.categoryBtnList = model
            self.collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension XMLYHomeVipCategoriesCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryBtnList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:XMLYVipCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMLYVipCategoryCell", for: indexPath) as! XMLYVipCategoryCell
        cell.backgroundColor = UIColor.white
        cell.categoryBtnModel = self.categoryBtnList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = self.categoryBtnList?[indexPath.row].properties?.uri else {
            let id = "0"
            let url = self.categoryBtnList?[indexPath.row].url ?? ""
//            delegate?.homeVipCategoriesCellItemClick(id: id, url: url, title: (self.categoryBtnList?[indexPath.row].title)!)
            print("id :\(id) url:\(url)")
            return
        }
        let id = getUrlCategoryId(url: string)
        let url = self.categoryBtnList?[indexPath.row].url ?? ""
//        delegate?.homeVipCategoriesCellItemClick(id: id, url: url,title:(self.categoryBtnList?[indexPath.row].title)!)
        print("id :\(id) url:\(url)")

    }
    
    
    func getUrlCategoryId(url:String) -> String {
        // 判断是否有参数
        if !url.contains("?") {
            return ""
        }
        var params = [String: Any]()
        // 截取参数
        let split = url.split(separator: "?")
        let string = split[1]
        // 判断参数是单个参数还是多个参数
        if string.contains("&") {
            // 多个参数，分割参数
            let urlComponents = string.split(separator: "&")
            // 遍历参数
            for keyValuePair in urlComponents {
                // 生成Key/Value
                let pairComponents = keyValuePair.split(separator: "=")
                let key:String = String(pairComponents[0])
                let value:String = String(pairComponents[1])
                
                params[key] = value
            }
        } else {
            // 单个参数
            let pairComponents = string.split(separator: "=")
            // 判断是否有值
            if pairComponents.count == 1 {
                return "nil"
            }
            
            let key:String = String(pairComponents[0])
            let value:String = String(pairComponents[1])
            params[key] = value as AnyObject
        }
        return params["category_id"] as! String
    }
}
