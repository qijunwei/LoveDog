//
//  DocCollectionViewCell.swift
//  LoveDog
//
//  Created by wei on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DocCollectionViewCell: UICollectionViewCell {
    var imageView = UIImageView()
    var nameLabel = UILabel()
    var jobLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        imageView.frame = CGRect(x: 10, y: 10, width: 70, height: 70)
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        
        nameLabel.frame = CGRect(x: 0, y: 90, width: 100, height: 20)
        nameLabel.textAlignment = .center
        self.contentView.addSubview(nameLabel)
        
        jobLabel.frame = CGRect(x: 0, y: 110, width: 100, height: 20)
        jobLabel.textColor = UIColor.gray
        jobLabel.font = UIFont.init(name: "STHeitiSC-Light", size: 13)
        jobLabel.textAlignment = .center
        self.contentView.addSubview(jobLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
