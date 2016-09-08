//
//  FeedsCell.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class FeedsCell: UITableViewCell {

    var headImage = UIImageView()
    var name = UILabel()
    var detailL = UILabel()
    var dateW = UILabel()
    var sharePhotos = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImage.frame = CGRectMake(16, 10, 70, 70)
        self.contentView.addSubview(headImage)
        
        name.frame = CGRectMake(110, 10, SCREEN_W - 115, 20)
        name.font = UIFont.init(name: "STHeitiSC-Light", size: 16)
        self.contentView.addSubview(name)
        
        detailL.frame = CGRectMake(110, 30, SCREEN_W - 115, 50)
        detailL.font = UIFont.init(name: "STHeitiSC-Light", size: 14)
        detailL.numberOfLines = 0
        
        self.contentView.addSubview(detailL)

        dateW.frame = CGRectMake(110, 60, SCREEN_W - 115, 40)
        dateW.font = UIFont.init(name: "STHeitiSC-Light", size: 13)
        dateW.numberOfLines = 2
        self.contentView.addSubview(dateW)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
