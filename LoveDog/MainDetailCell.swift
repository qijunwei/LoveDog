//
//  MainDetailCell.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainDetailCell: UITableViewCell {

    var image1 = UIImageView()
    var title = UILabel()
    var good = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        image1.frame = CGRectMake(16, 10, 80, 60)
        self.contentView.addSubview(image1)
        
        title.frame = CGRectMake(110, 10, SCREEN_W - 105, 20)
        title.font = UIFont.init(name: "STHeitiSC-Light", size: 16)
        self.contentView.addSubview(title)
        
        good.frame = CGRectMake(110, 50, SCREEN_W - 105, 30)
        good.font = UIFont.init(name: "STHeitiSC-Light", size: 13)
        self.contentView.addSubview(good)

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
