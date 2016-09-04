//
//  ThanksViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/20.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class ThanksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()

        let label1 = UILabel.init(frame: CGRectMake(10, 64, SCREEN_W - 20, 30))
        label1.text = "技术支持:"
        label1.font = UIFont.init(name: "STHeitiSC-Light", size: 17)
        self.view.addSubview(label1)
        let label11 = UILabel.init(frame: CGRectMake(10, 94, SCREEN_W - 20, 30))
        label11.text = "superk589"
        label11.font = UIFont.init(name: "STHeitiSC-Light", size: 17)
        self.view.addSubview(label11)
        
        let label2 = UILabel.init(frame: CGRectMake(10, 124, SCREEN_W - 20, 30))
        label2.text = "界面设计:"
        label2.font = UIFont.init(name: "STHeitiSC-Light", size: 17)
        self.view.addSubview(label2)
        let label21 = UILabel.init(frame: CGRectMake(10, 154, SCREEN_W - 20, 30))
        label21.text = "HZY"
        label21.font = UIFont.init(name: "STHeitiSC-Light", size: 17)
        self.view.addSubview(label21)
    }
}
