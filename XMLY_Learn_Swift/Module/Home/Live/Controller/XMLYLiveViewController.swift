//
//  XMLYLiveViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYLiveViewController: XMLYBaseViewController {

   var lives:[XMLYLivesModel]?
    
    private let XMLYHomeLiveHeaderViewID = "XMLYHomeLiveHeaderView"
    private let XMLYHomeLiveGridCellID   = "XMLYHomeLiveGridCell"
    private let XMLYHomeLiveBannerCellID = "XMLYHomeLiveBannerCell"
    private let XMLYHomeLiveRankCellID   = "XMLYHomeLiveRankCell"
    private let XMLYRecommendLiveCellID = "XMLYRecommendLiveCell"

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // 注册头视图和尾视图
        collection.register(XMLYHomeLiveHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYHomeLiveHeaderViewID)
        // 注册不同分区cell
        collection.register(XMLYRecommendLiveCell.self, forCellWithReuseIdentifier: XMLYRecommendLiveCellID)
        collection.register(XMLYHomeLiveGridCell.self, forCellWithReuseIdentifier:XMLYHomeLiveGridCellID)
        collection.register(XMLYHomeLiveBannerCell.self, forCellWithReuseIdentifier:XMLYHomeLiveBannerCellID)
        collection.register(XMLYHomeLiveRankCell.self, forCellWithReuseIdentifier:XMLYHomeLiveRankCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadLiveData() }
        return collection
    }()
    
    lazy var viewModel: XMLYHomeLiveViewModel = {
        return XMLYHomeLiveViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        // 刚进页面进行刷新
        self.collectionView.uHead.beginRefreshing()
        loadLiveData()
    }
    
    func loadLiveData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }

}
// - collectionviewDelegate
extension XMLYLiveViewController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case XMLYHomeLiveSectionGrid:
            let cell:XMLYHomeLiveGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHomeLiveGridCellID, for: indexPath) as! XMLYHomeLiveGridCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
//            cell.delegate = self
            return cell
        case XMLYHomeLiveSectionBanner:
            let cell:XMLYHomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHomeLiveBannerCellID, for: indexPath) as! XMLYHomeLiveBannerCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.bannerList = viewModel.homeLiveBanerList
            return cell
        case XMLYHomeLiveSectionRank:
            let cell:XMLYHomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHomeLiveRankCellID, for: indexPath) as! XMLYHomeLiveRankCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.backgroundColor = UIColor.red
            cell.multidimensionalRankVos = viewModel.multidimensionalRankVos
            return cell
        default:
            let cell:XMLYRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYRecommendLiveCellID, for: indexPath) as! XMLYRecommendLiveCell
            cell.liveData = viewModel.lives?[indexPath.row]
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
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : XMLYHomeLiveHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYHomeLiveHeaderViewID, for: indexPath) as! XMLYHomeLiveHeaderView
//            headerView.delegate = self
            headerView.backgroundColor = UIColor.white
            return headerView
        }else {
            return UICollectionReusableView()
        }
    }
}




