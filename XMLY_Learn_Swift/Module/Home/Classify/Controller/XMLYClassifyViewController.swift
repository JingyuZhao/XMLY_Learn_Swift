//
//  XMLYClassifyViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYClassifyViewController: XMLYBaseViewController {
    
    private let XMLYClassifyHeaderViewID : String = "XMLYClassifyHeaderViewID"
    private let XMLYClassifyFooterViewID : String = "XMLYClassifyFooterViewID"
    
    
    lazy var collectionView : UICollectionView = {
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        
        let collectionView : UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = XMLYDownColor
        
        collectionView.register(XMLYClassifyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYClassifyHeaderViewID)
        collectionView.register(XMLYClassifyFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYClassifyFooterViewID)
        
        collectionView.uHead = URefreshHeader.init(refreshingBlock: {[weak self] in
            self?.loadData()
        })
        
        return collectionView
    }()
    
    lazy var classifyViewModel : XMLYClassifyViewModel = {
        let viewModel = XMLYClassifyViewModel()
        return viewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        loadData()
        
    }
    
    override func configUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    
    func loadData() {
        self.classifyViewModel.updataBlock = {[unowned self] in
            self.collectionView.uHead.endRefreshing()
            self.collectionView.reloadData()
        }
        self.classifyViewModel.refreshDataSource()
    }
    
}
extension XMLYClassifyViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.classifyViewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.classifyViewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "\(indexPath.section)+\(indexPath.row)"
        collectionView.register(XMLYClassifyViewCell.self, forCellWithReuseIdentifier: identifier)
        let cell : XMLYClassifyViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! XMLYClassifyViewCell
        cell.itemModel = self.classifyViewModel.classifyModel?[indexPath.section].itemList?[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return classifyViewModel.insetForSectionAt(section: section)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return classifyViewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return classifyViewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return classifyViewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return classifyViewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return classifyViewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : XMLYClassifyHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYClassifyHeaderViewID, for: indexPath) as! XMLYClassifyHeaderView
            headerView.titleString = classifyViewModel.classifyModel?[indexPath.section].groupName
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footerView : XMLYClassifyFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYClassifyFooterViewID, for: indexPath) as! XMLYClassifyFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let categoryId:Int = classifyViewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.categoryId ?? 0
        let title = classifyViewModel.classifyModel?[indexPath.section].itemList![indexPath.row].itemDetail?.title ?? ""
        let subClassify = XMLYSubClassifyViewController.init(categoryId: categoryId, isVipPush: false)
        subClassify.title = title
        self.navigationController?.pushViewController(subClassify, animated: true)
    }
}
