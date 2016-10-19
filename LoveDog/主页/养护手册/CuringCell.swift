//
//  CuringCell.swift
//  LoveDog
//
//  Created by wei on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CuringCell: UITableViewCell {

    var image1 = UIImageView()
    var title = UILabel()
    var summary = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        image1.frame = CGRect(x: 16, y: 10, width: 80, height: 60)
        self.contentView.addSubview(image1)
        
        title.frame = CGRect(x: 110, y: 10, width: SCREEN_W - 115, height: 50)
        title.numberOfLines = 2
        title.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        self.contentView.addSubview(title)
        
        summary.frame = CGRect(x: 110, y: 50, width: SCREEN_W - 105, height: 30)
        summary.font = UIFont.init(name: "STHeitiSC-Light", size: 13)
        self.contentView.addSubview(summary)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

