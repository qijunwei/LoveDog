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
        

        imageView.frame = CGRectMake(20, 20, 70, 70)
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.clipsToBounds = true
        self.contentView.addSubview(imageView)
        
        nameLabel.frame = CGRectMake(0, 110, 100, 30)
        nameLabel.textAlignment = .Center
        self.contentView.addSubview(nameLabel)
        
        jobLabel.frame = CGRectMake(0, 140, 100, 30)
        jobLabel.textAlignment = .Center
        self.contentView.addSubview(jobLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}