//
//  DogDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DogDetailViewController: UIViewController {

    var scrollView = UIScrollView()//整个页面可以滚动
    var imageView = UIImageView()//上面的大图展示
    var lable = UILabel()//下面的文字展示
    var nameLabel = UILabel()//狗的名字
    var collect = false//收藏

    //增加分享按钮
    var rightItem: UIBarButtonItem?
    var shareTitle:String?
    var shareUrl:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        self.createScrollView()
        
        //增加分享功能
        rightItem = UIBarButtonItem.init(title: "分享", style: .Plain, target:self, action: #selector(self.shareTo))
        rightItem?.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = rightItem

    }
    
    func shareTo(){
        let shareParames = NSMutableDictionary()
        shareParames.SSDKSetupShareParamsByText("骨小八狗狗图片分享", images: UIImage.init(named: "Icon-Spotlight-40"), url: NSURL.init(string: shareUrl!), title: shareTitle, type: SSDKContentType.Auto)
        
        ShareSDK.showShareActionSheet(view, items: [SSDKPlatformType.TypeWechat.rawValue,SSDKPlatformType.TypeQQ.rawValue], shareParams: shareParames) { (state, platformType, userdata, contentEnity, error, end) in
            switch state {
            case SSDKResponseState.Success:
                print("分享成功")
            case SSDKResponseState.Fail:
                print("分享失败")
            case SSDKResponseState.Cancel:
                print("取消分享")
            default:
                break
            }
        }
    }

    func createScrollView(){
        scrollView.frame = UIScreen.mainScreen().bounds
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        imageView.frame = CGRectMake(3, 0, SCREEN_W - 6, 250)
        scrollView.addSubview(imageView)
        
        //遮挡网络图片上的logo
        let coverView = UIView()
        coverView.backgroundColor = UIColor.whiteColor()
        coverView.frame = CGRectMake(0, 220, SCREEN_W - 6, 30)
        imageView.addSubview(coverView)
        
        nameLabel.frame = CGRectMake(11, CGFloat(imageView.frame.origin.y + 250), SCREEN_W - 20, 20)
        nameLabel.font = UIFont.boldSystemFontOfSize(22)
        //因为在屏幕尺寸比较小的情况下，dogname会出边框
        nameLabel.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(nameLabel)
        
        lable.frame = CGRectMake(10, CGFloat(imageView.frame.origin.y + 290), SCREEN_W - 20, 250)
        lable.font = UIFont.init(name: "STHeitiSC-Light", size: 17)//设置字体
        lable.textColor = TEXTGRYCOLOR
        lable.numberOfLines = 0
        lable.sizeToFit()
        scrollView.addSubview(lable)
        
        scrollView.contentSize = CGSizeMake(0, imageView.frame.height + lable.frame.height + 50 )
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
