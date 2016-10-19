//
//  MyselfViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController,MFMailComposeViewControllerDelegate {
    
    var tableView: UITableView!//整个页面
    var dataArr = [[String]]()
    var big:Int? //用于统计文件夹所有文件大小
    var files:[String]?
    var cachePath: String?
//    var headView:UIView!//头视图
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.

        self.title = "设置"
        dataArr = [["评价","声明"],["清理缓存","意见反馈","联系我们"]]
        self.createTableView()
    }
    
    func createTableView(){
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64), style: UITableViewStyle.grouped)
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
//
    }
    
    //计算缓存
    func calculateCache(){
        //清除缓存  实现清除缓存功能。主要分为统计缓存文件大小和删除缓存文件两个步骤：
        //取出chche文件夹路径
        cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        //  print(cachePath)
        //取出文件夹下所有文件数组
        files = FileManager.default.subpaths(atPath: cachePath!)
        big = Int() //用于统计文件夹所有文件大小
        for p in files!{//快速枚举所有文件名
            //把文件名拼接到路径中
            let path = cachePath!.appendingFormat("/\(p)")
            //取出文件属性
            let folder = try! FileManager.default.attributesOfItem(atPath: path)
            for (abc,bcd) in folder{ //用元组取出文件属性大小
                if abc == FileAttributeKey.size{//只取出文件大小进行拼接
                    big! += (bcd as AnyObject).intValue
                }
            }
        }
    }
    //清理缓存
    func wipeCache(){
        let  message = "\(big!/(1024*1024))M缓存"
        let alter = UIAlertController.init(title: "清除缓存?", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
            for p in self.files!{ //点击确定是删除
                let path = self.cachePath!.appendingFormat("/\(p)")
                if (FileManager.default.fileExists(atPath: path)){
                    do{ //防止异常崩溃
                        try FileManager.default.removeItem(atPath: path)
                    }catch{
                        
                    }
                }
            }
        }
        alter.addAction(action)
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.cancel) { (cancle) in
        }
        alter.addAction(cancle)
        self.navigationController?.present(alter, animated: true, completion: nil)
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
        
        let sendMailErrorAlert = UIAlertController(title: "无法发送邮件", message: "您的设备尚未设置邮箱，请在“邮件”应用中设置后再尝试发送。", preferredStyle: .alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "确定", style: .default) { _ in })
        self.present(sendMailErrorAlert, animated: true){}
        
    }
    //    写上 dismiss 邮件视窗的函数
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            print("取消发送")
        case MFMailComposeResult.sent.rawValue:
            print("发送成功")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionArray = self.dataArr[section]
        //行数
        return sectionArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mine")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "mine")
        }
        cell?.textLabel?.text = dataArr[(indexPath as NSIndexPath).section][(indexPath as NSIndexPath).row]
        cell?.textLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 18)
        
        let imageNext = UIImageView.init(frame: CGRect(x: SCREEN_W - 35, y: 15, width: 10, height: 15))
        imageNext.image = UIImage.init(named: "766-arrow-right")
        cell?.contentView.addSubview(imageNext)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath as NSIndexPath).section == 0{
            if (indexPath as NSIndexPath).row == 0 {
                //跳转到appstore评价界面
                let appid = APPId
                let url = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appid)"
                UIApplication.shared.openURL(URL.init(string: url)!)
            }
            else if (indexPath as NSIndexPath).row == 1 {
                let thankVc = ThankViewController()
                thankVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(thankVc, animated: true)
            }
        }else {
            if (indexPath as NSIndexPath).row == 0{
                //清理缓存
                self.calculateCache()
                self.wipeCache()
            }else if (indexPath as NSIndexPath).row == 1 {
                if MFMailComposeViewController.canSendMail() {
                    // 注意这个实例要写在 if block 里，否则无法发送邮件时会出现两次提示弹窗（一次是系统的）
                    let mailComposeViewController = configuredMailComposeViewController()
                    self.present(mailComposeViewController, animated: true, completion: nil)
                } else {
                    self.showSendMailErrorAlert()
                }
            }else if (indexPath as NSIndexPath).row == 2 {
                //联系我们 跳转到拨打电话
                let webview = UIWebView()
                let url = URL.init(string: "tel:18221506195")
                webview.loadRequest(URLRequest.init(url: url!))
                self.view.addSubview(webview)
            }
        }
    }
}
