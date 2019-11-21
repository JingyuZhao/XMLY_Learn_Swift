//
//  XMLYFindDucCell.swift
//  XMLY_Learn_Swift
//
//  Created by zhaojingyu on 2019/11/8.
//  Copyright © 2019 XMLY. All rights reserved.
//

import UIKit

class XMLYFindDucCell: UITableViewCell {

    var findDucModel : XMLYFindDudModel?{
        didSet {
            print("set")
            guard let model = findDucModel else {return}
            self.coverImageView.kf.setImage(with: URL.init(string: model.dubbingItem?.coverLarge ?? ""))
            self.nickNameLabel.text = model.dubbingItem?.intro
            self.headImageView.kf.setImage(with: URL(string: (model.dubbingItem?.logoPic)!))
            let zanNum:Int = (model.dubbingItem?.favorites)!
            let commentNum:Int = (model.dubbingItem?.commentCount)!
            self.zanLabel.text = "\(zanNum)"
            self.commentLabel.text = "\(commentNum)"
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var zanLabel: UILabel!
    
    @IBOutlet weak var commentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.coverImageView.layer.masksToBounds = true
        self.coverImageView.layer.cornerRadius = 5
        
        self.headImageView.layer.masksToBounds = true
        self.headImageView.layer.cornerRadius = self.headImageView.bounds.size.width*0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
