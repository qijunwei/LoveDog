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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        dataArr = [["评价","致谢"],["清理缓存","意见反馈","联系我们"]]
        self.createTableView()
    }

    func createTableView(){
        
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Grouped)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        headView = UIView.init(frame: CGRectMake(0, 64, SCREEN_W, 120))
        let logoview = UIImageView.init(frame: CGRectMake((SCREEN_W - 100) / 2, 0, 100, 100))
        logoview.image = UIImage.init(named: "graylogo")
        headView.addSubview(logoview)
        let logolabel = UILabel.init(frame: CGRectMake((SCREEN_W - 80) / 2, 100, 100, 10))
        logolabel.text = "骨小八 v1.1"
        logolabel.textColor = UIColor.grayColor()
        logolabel.font = UIFont.systemFontOfSize(15)
        headView.addSubview(logolabel)
        tableView.tableHeaderView = headView
    }
    
    //计算缓存
    func calculateCache(){
        //清除缓存  实现清除缓存功能。主要分为统计缓存文件大小和删除缓存文件两个步骤：
        //取出chche文件夹路径
        cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
        
        //  print(cachePath)
        //取出文件夹下所有文件数组
        files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
        big = Int() //用于统计文件夹所有文件大小
        for p in files!{//快速枚举所有文件名
            //把文件名拼接到路径中
            let path = cachePath!.stringByAppendingFormat("/\(p)")
            //取出文件属性
            let folder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
            for (abc,bcd) in folder{ //用元组取出文件属性大小
                if abc == NSFileSize{//只取出文件大小进行拼接
                    big! += bcd.integerValue
                }
            }
        }
    }
    //清理缓存
    func wipeCache(){
        let  message = "\(big!/(1024*1024))M缓存"
        let alter = UIAlertController.init(title: "清除缓存?", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            for p in self.files!{ //点击确定是删除
                let path = self.cachePath!.stringByAppendingFormat("/\(p)")
                if (NSFileManager.defaultManager().fileExistsAtPath(path)){
                    do{ //防止异常崩溃
                        try NSFileManager.defaultManager().removeItemAtPath(path)
                    }catch{
                        
                    }
                }
            }
        }
        alter.addAction(action)
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) in
        }
        alter.addAction(cancle)
        self.navigationController?.presentViewController(alter, animated: true, completion: nil)
    }
    
    //发送邮件
//    配置发邮件的视窗
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        
        // 设置邮件地址、主题及正文
        mailComposeVC.setToRecipients(["< 175500547@qq.com >"])
        mailComposeVC.setSubject("< 用户反馈 >")
        mailComposeVC.setMessageBody("< 邮件正文 >", isHTML: false)
        
        return mailComposeVC
    }
//    鉴于这种发送邮件的方式，要求用户已经在设备上至少添加有一个邮箱，所以对没有设置邮箱的用户，还应予以提示。因此这里再写一个函数，来配置针对未设置邮箱用户的弹窗提醒
    func showSendMailErrorAlert() {
        
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .Alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .Default) { _ in })
        self.presentViewController(sendMailErrorAlert, animated: true){}
        
    }
//    写上 dismiss 邮件视窗的函数
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("取消发送")
        case MFMailComposeResultSent.rawValue:
            print("发送成功")
        default:
            break
        }
        self.dismissViewControllerAnimated(true, completion: nil)
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
        if section == 0{
            return 0.1
        }else{
        return 40
        }
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if (indexPath.section == 0 && indexPath.row == 0) {
            //跳转到appstore评价界面
            let appid = APPId
            let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appid)"
            UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
        }else if (indexPath.section == 1 && indexPath.row == 0) {
            //清理缓存
            self.calculateCache()
            self.wipeCache()
        }else if (indexPath.section == 0 && indexPath.row == 1) {
            let thankVc = ThanksViewController()
            self.navigationController?.pushViewController(thankVc, animated: true)
            thankVc.hidesBottomBarWhenPushed = true
            
        }else if (indexPath.section == 1 && indexPath.row == 1) {
            if MFMailComposeViewController.canSendMail() {
                // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
                let mailComposeViewController = configuredMailComposeViewController()
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
        }else if (indexPath.section == 1 && indexPath.row == 2) {
            //联系我们 跳转到拨打电话
            let webview = UIWebView()
            let url = NSURL.init(string: "tel:18221506195")
            webview.loadRequest(NSURLRequest.init(URL: url!))
            self.view.addSubview(webview)
        }
    }
}
