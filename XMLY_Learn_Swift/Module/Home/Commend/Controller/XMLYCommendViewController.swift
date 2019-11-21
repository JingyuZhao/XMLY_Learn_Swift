//
//  XMLYCommendViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/5.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages
import MJRefresh

class XMLYCommendViewController: XMLYBaseViewController {
    //头尾部视图
    private let XMLYCommendHeaderViewID = "XMLYCommendHeaderViewID"
    private let XMLYCommendFooterViewID = "XMLYCommendFooterViewID"

    //注册cell
    private let XMLYCommendHeaderCellID = "XMLYCommendHeaderCellID"
    
    // 猜你喜欢
    private let XMLYRecommendGuessLikeCellID  = "XMLYRecommendGuessLikeCellID"
    // 热门有声书
    private let XMLYHotAudiobookCellID        = "XMLYHotAudiobookCell"
    // 广告
    private let XMLYAdvertCellID              = "XMLYAdvertCell"
    // 懒人电台
    private let XMLYOneKeyListenCellID        = "XMLYOneKeyListenCell"
    // 为你推荐
    private let XMLYRecommendForYouCellID     = "XMLYRecommendForYouCell"
    // 推荐直播
    private let XMLYHomeRecommendLiveCellID   = "XMLYHomeRecommendLiveCell"
    
    

    var recommendAdList : [XMLYRecommnedAdvertModel]?
    
    
    //UICollection
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        
        collectionView.register(XMLYHomeCommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYCommendHeaderViewID)
        collectionView.register(XMLYHomeCommendFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYCommendFooterViewID)

        collectionView.register(XMLYHomeCommendHeaderCell.self, forCellWithReuseIdentifier: XMLYCommendHeaderCellID)
        collectionView.register(XMLYRecommendGuessLikeCell.self, forCellWithReuseIdentifier: XMLYRecommendGuessLikeCellID)
        collectionView.register(XMLYHotAudiobookCell.self, forCellWithReuseIdentifier: XMLYHotAudiobookCellID)
        collectionView.register(XMLYAdvertCell.self, forCellWithReuseIdentifier: XMLYAdvertCellID)
        collectionView.register(XMLYOneKeyListenCell.self, forCellWithReuseIdentifier: XMLYOneKeyListenCellID)
        collectionView.register(XMLYHomeRecommendLiveCell.self, forCellWithReuseIdentifier: XMLYHomeRecommendLiveCellID)
        collectionView.register(XMLYRecommendForYouCell.self, forCellWithReuseIdentifier: XMLYRecommendForYouCellID)

        collectionView.uHead = URefreshHeader.init(refreshingBlock: {[weak self] in
            self?.loadData()
        })
        
        return collectionView
        
    }()
    
    //viewModel
    lazy var commendViewModel : XMLYCommendViewModel = {
        let viewModel = XMLYCommendViewModel()
        return viewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadCommendData()
    }
    
    override func configUI() {
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        self.collectionView.uHead.beginRefreshing()
       
    }
    
    //刷新加载数据
    func loadData(){
        self.commendViewModel.updateData = {[unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        self.commendViewModel.refreshDataScoure()

    }
    
    //首页穿插广告接口请求
    func loadCommendData() {
        XMLYHomeCommendProvider.request(.recommendAdList) { result in
            if case let .success(respone) = result {
                // 解析数据
                let data = try? respone.mapJSON()
                guard let newData = data else { return }
                let json = JSON(newData)
                if let advertList = JSONDeserializer<XMLYRecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                    self.recommendAdList = advertList as? [XMLYRecommnedAdvertModel]
                    self.collectionView.reloadData()
                }
            }
        }
    }

}
extension XMLYCommendViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.commendViewModel.numberOfSections(collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.commendViewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // 每个分区的内边距
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.commendViewModel.insetForSectionAt(section: section)
       }
       
    // 最小item间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return self.commendViewModel.minimumInteritemSpacingForSectionAt(section: section)
    }
    
    // 最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.commendViewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    // item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.commendViewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return self.commendViewModel.referenceSizeForHeaderInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return self.commendViewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView : XMLYHomeCommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: XMLYCommendHeaderViewID, for: indexPath) as! XMLYHomeCommendHeaderView
            headerView.homeRecommendList = commendViewModel.homeCommendList?[indexPath.section]
            
            return headerView
        }else if kind == UICollectionView.elementKindSectionFooter {
            let footer : XMLYHomeCommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: XMLYCommendFooterViewID, for: indexPath) as! XMLYHomeCommendFooterView
            footer.backgroundColor = .white
            return footer
        }else{
            return UICollectionReusableView()

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = self.commendViewModel.homeCommendList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell:XMLYHomeCommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYCommendHeaderCellID, for: indexPath) as! XMLYHomeCommendHeaderCell
            cell.focusModel = self.commendViewModel.focus
            cell.squareList = self.commendViewModel.squareList
            cell.topBuzzListData = self.commendViewModel.topBuzzList
//            cell.delegate = self
            return cell
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            // 横式排列布局cell
            let cell:XMLYRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYRecommendGuessLikeCellID, for: indexPath) as! XMLYRecommendGuessLikeCell
//            cell.delegate = self
            cell.recommendListData = self.commendViewModel.homeCommendList?[indexPath.section].list
            return cell
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
            let cell:XMLYHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHotAudiobookCellID, for: indexPath) as! XMLYHotAudiobookCell
//            cell.delegate = self
            cell.recommendListData = commendViewModel.homeCommendList?[indexPath.section].list
            return cell
        }else if moduleType == "ad" {
            let cell:XMLYAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYAdvertCellID, for: indexPath) as! XMLYAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommendAdList?[0]
            }else if indexPath.section == 13 {
                cell.adModel = self.recommendAdList?[1]
             }else if indexPath.section == 17 {
            // cell.adModel = self.recommnedAdvertList?[2]
            }
            return cell
        }else if moduleType == "oneKeyListen" {
            let cell:XMLYOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYOneKeyListenCellID, for: indexPath) as! XMLYOneKeyListenCell
            cell.oneKeyListenList = commendViewModel.oneKeyListenList
            return cell
        }else if moduleType == "live" {
            let cell:XMLYHomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYHomeRecommendLiveCellID, for: indexPath) as! XMLYHomeRecommendLiveCell
//            cell.liveList = viewModel.liveList
            return cell
        }else {
            let cell:XMLYRecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: XMLYRecommendForYouCellID, for: indexPath) as! XMLYRecommendForYouCell
            return cell
            
        }
    }
}
