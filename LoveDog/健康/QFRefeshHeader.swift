//
//  QFRefeshHeader.swift
//  LoveDog
//
//  Created by wei on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MJRefresh

class QFRefeshHeader: MJRefreshNormalHeader {

    
    override func placeSubviews() {
        
        super.placeSubviews()
        self.mj_y = -self.mj_h - self.ignoredScrollViewContentInsetTop - 80;
        
    }
    
}
