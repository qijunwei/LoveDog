//
//  PhotoView.swift
//  LoveDog
//
//  Created by wei on 16/9/9.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    var photo = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        photo.frame = self.frame
        self.addSubview(photo)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
