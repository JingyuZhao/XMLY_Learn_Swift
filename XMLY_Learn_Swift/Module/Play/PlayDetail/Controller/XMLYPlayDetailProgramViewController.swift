//
//  XMLYPlayDetailProgramViewController.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/12.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit
import LTScrollView

class XMLYPlayDetailProgramViewController: XMLYBaseViewController,LTTableViewProtocal {
    
    private var playDetailTracks:XMLYPlayDetailTracksModel?
    private let XMLYPlayDetailProgramCellID : String = "XMLYPlayDetailProgramCellID"
    private lazy var tableView : UITableView = {
        let tableView = tableViewConfig(CGRect.init(x: 0, y: 0, width: XMLYScreenWidth, height: XMLYScreenHeight), self, self, nil)
        tableView.register(XMLYPLayDetailProgramCell.self, forCellReuseIdentifier: XMLYPlayDetailProgramCellID)
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        return tableView
    }()
    
    var playDetailTracksModel:XMLYPlayDetailTracksModel?{
        didSet{
            guard let model = playDetailTracksModel else {return}
            self.playDetailTracks = model
            //               self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func configUI() {
        self.view.addSubview(self.tableView)
        glt_scrollView = tableView
    }

    
}
extension XMLYPlayDetailProgramViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XMLYPlayDetailProgramCellID, for: indexPath) as! XMLYPLayDetailProgramCell
        cell.indexPath = indexPath
        cell.playDetailTracksList = self.playDetailTracks?.list?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.playDetailTracks?.list?[indexPath.row].albumId ?? 0
        let trackUid = self.playDetailTracks?.list?[indexPath.row].trackId ?? 0
        let uid = self.playDetailTracks?.list?[indexPath.row].uid ?? 0
        let vc = XMLYNavigationController.init(rootViewController: XMLYPlayDetailPlayerViewController(albumId:albumId, trackUid:trackUid, uid:uid))
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
