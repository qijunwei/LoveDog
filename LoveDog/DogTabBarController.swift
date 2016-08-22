//
//  ViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DogTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //狗的所有种类，可根据名字进行搜索 点进去详情，并可以收藏
        let vc1 = KindSearchViewController()
        let nvc1 = UINavigationController(rootViewController: vc1)
        vc1.tabBarItem.image = UIImage(named: "分类")
        nvc1.navigationBar.barTintColor = GRAYCOLOR2
        vc1.title = "种类"

        //医生医院：添加地图功能，可搜索附近的医院医生
        let vc2 = DogHealthViewController()
        let nvc2 = UINavigationController(rootViewController: vc2)
        vc2.tabBarItem.title = "健康"
        vc2.tabBarItem.image = UIImage(named: "药箱")

        
        //自家狗狗的展现、分享
        let vc3 = MainViewController()
        let nvc3 = UINavigationController(rootViewController: vc3)
        vc3.title = "主页"
        vc3.tabBarItem.image = UIImage(named: "社区")
        
        //个人信息、设置、地理位置、发送消息、我的收藏、支付打赏等
        let vc4 = MyselfViewController()
        let nvc4 = UINavigationController(rootViewController: vc4)
        vc4.title = "设置"
        vc4.tabBarItem.image = UIImage(named: "我")
        
        //将四个导航控制器添加到标签栏
        self.viewControllers = [nvc3,nvc2,nvc1,nvc4]
        //设置标签选中颜色
        self.tabBar.barTintColor = GRAYCOLOR2
        self.tabBar.tintColor = UIColor.orangeColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

