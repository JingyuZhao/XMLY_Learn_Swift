//
//  XMLYBroadcastViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

let XMLYHomeBroadcastSectionTel     = 0   // 电台section
let XMLYHomeBroadcastSectionMoreTel = 1   // 可展开电台section
let XMLYHomeBroadcastSectionLocal   = 2   // 本地section
let XMLYHomeBroadcastSectionRank    = 3   // 排行榜section

class XMLYBroadcastViewController: XMLYBaseViewController {
    
    private let XMLYRadioHeaderViewID = "XMLYRadioHeaderView"
    private let XMLYRadioFooterViewID = "XMLYRadioFooterView"
    private let XMLYHomeRadiosCellID = "XMLYHomeRadiosCell"
    private let XMLYRadioCategoriesCellID = "XMLYRadioCategoriesCell"
    private let XMLYRadioSquareResultsCellID   = "XMLYRadioSquareResultsCell"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // MARK -注册头视图和尾视图
        collection.register(XMLYRadioHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYRadioHeaderViewID)
        collection.register(XMLYRadioFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYRadioFooterViewID)
        // 注册不同分区cell
        collection.register(XMLYHomeRadiosCell.self, forCellWithReuseIdentifier:XMLYHomeRadiosCellID)
        collection.register(XMLYRadioSquareResultsCell.self, forCellWithReuseIdentifier:XMLYRadioSquareResultsCellID)
        
        collection.uHead = URefreshHeader{ [weak self] in self?.setupLoadData() }
        return collection
    }()
    
    lazy var viewModel: XMLYHomeBroadcastViewModel = {
        return XMLYHomeBroadcastViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        setupLoadData()
    }
    
    func setupLoadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension XMLYBroadcastViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
     func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 4
       }
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return viewModel.numberOfItemsIn(section: section)
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           switch indexPath.section {
           case XMLYHomeBroadcastSectionTel: // 顶部电台
               let cell:XMLYRadioSquareResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYRadioSquareResultsCellID, for: indexPath) as! XMLYRadioSquareResultsCell
               cell.radioSquareResultsModel = viewModel.radioSquareResults
//               cell.delegate = self
               return cell
           case XMLYHomeBroadcastSectionMoreTel: // 可展开更多的电台
               let identifier:String = "\(indexPath.section)\(indexPath.row)"
               self.collectionView.register(XMLYRadioCategoriesCell.self, forCellWithReuseIdentifier: identifier)
               let cell:XMLYRadioCategoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! XMLYRadioCategoriesCell
               cell.backgroundColor = UIColor.init(red: 248/255.0, green: 245/255.0, blue: 246/255.0, alpha: 1)
               cell.dataSource = viewModel.categories?[indexPath.row].name
               cell.layer.masksToBounds = true
               cell.layer.cornerRadius = 2
               return cell
           default:
               let cell:XMLYHomeRadiosCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHomeRadiosCellID, for: indexPath) as! XMLYHomeRadiosCell
               if indexPath.section == XMLYHomeBroadcastSectionLocal{ // 本地电台
                   cell.localRadioModel = viewModel.localRadios?[indexPath.row]
               }else {
                   cell.topRadioModel = viewModel.topRadios?[indexPath.row]
               }
               return cell
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
           
       }
       
       // 每个分区的内边距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return viewModel.insetForSectionAt(section: section)
       }
       
       // 最小 item 间距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return viewModel.minimumInteritemSpacingForSectionAt(section: section)
       }
       
       // 最小行间距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return viewModel.minimumLineSpacingForSectionAt(section: section)
       }
       
       // item 的尺寸
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return viewModel.sizeForItemAt(indexPath: indexPath)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
           return viewModel.referenceSizeForHeaderInSection(section: section)
       }
       
       func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           if kind == UICollectionView.elementKindSectionHeader {
               let headerView :XMLYRadioHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYRadioHeaderViewID, for: indexPath) as! XMLYRadioHeaderView
               headerView.backgroundColor = UIColor.white
               headerView.titStr = viewModel.titleArray[indexPath.section - 2]
               return headerView
           }else {
               let footerView :XMLYRadioFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYRadioFooterViewID, for: indexPath) as! XMLYRadioFooterView
               return footerView
               
           }
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
           return viewModel.referenceSizeForFooterInSection(section: section)
       }
}
