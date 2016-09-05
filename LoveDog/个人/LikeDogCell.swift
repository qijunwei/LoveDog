//
//  LikeDogCell.swift
//  LoveDog
//
//  Created by wei on 16/9/5.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class LikeDogCell: UITableViewCell {

    
    var headImage = UIImageView()
    var title = UILabel()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        headImage.frame = CGRectMake(16, 5, 35, 35)
        self.contentView.addSubview(headImage)
        
        title.frame = CGRectMake(60, 5, SCREEN_W - 100, 35)
        title.font = UIFont.init(name: "STHeitiSC-Light", size: 18)
        self.contentView.addSubview(title)

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
