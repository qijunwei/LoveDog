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
        
        headImage.frame = CGRect(x: 16, y: 5, width: 35, height: 35)
        self.contentView.addSubview(headImage)
        
        title.frame = CGRect(x: 60, y: 5, width: SCREEN_W - 100, height: 35)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
