//
//  MyselfViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MessageUI

class MyselfViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var tableView: UITableView!//整个页面
    var dataArr = [[String]]()
    var big:Int? //用于统计文件夹所有文件大小
    var files:[String]?
    var cachePath: String?
    var headView:UIView!//头视图
    var logoview:UIImageView!//登录后的头像
    var nickname:UILabel!//登陆后的昵称
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        //推送设置暂时不加
        dataArr = [["我的收藏","消息通知"],["地图导航","扫一扫","文字朗读"],["设置"]]
        self.createTableView()
    }
    
    func createTableView(){
        
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Grouped)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        headView = UIView.init(frame: CGRectMake(0, 64, SCREEN_W, 100))
        headView.backgroundColor = UIColor.whiteColor()
        logoview = UIImageView.init(frame: CGRectMake(10, 10, 80, 80))
        logoview.image = UIImage.init(named: "兔兔1.jpg")
//        logoview.layer.cornerRadius = logoview.frame.size.height - 10
        logoview.clipsToBounds = true
        headView.addSubview(logoview)
        
        nickname = UILabel.init(frame: CGRectMake(110, 20, SCREEN_W - 120, 20))
        nickname.adjustsFontSizeToFitWidth = true
        nickname.text = "点击登录"
        headView.addSubview(nickname)

        tableView.tableHeaderView = headView

    }
}
extension MyselfViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionArray = self.dataArr[section]
        //行数
        return sectionArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("mine")
        if cell == nil {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "mine")
        }
        cell?.textLabel?.text = dataArr[indexPath.section][indexPath.row]
        cell?.textLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 18)
        
        let imageNext = UIImageView.init(frame: CGRectMake(SCREEN_W - 35, 15, 10, 15))
        imageNext.image = UIImage.init(named: "766-arrow-right")
        cell?.contentView.addSubview(imageNext)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 20
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            if indexPath.row == 0{
            let likeVc = LikeDogViewController()
            likeVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(likeVc, animated: true)
            }
            
        }else if indexPath.section == 2 {
                let setVc = SettingsViewController()
                setVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(setVc, animated: true)
        }
    }
}
