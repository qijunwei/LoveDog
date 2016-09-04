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
    var isCollect = false//收藏状态

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
        shareParames.SSDKSetupShareParamsByText("骨小八狗狗图片分享", images: UIImage.init(named: "graylogo"), url: NSURL.init(string: shareUrl!), title: shareTitle, type: SSDKContentType.Auto)
//        ,SSDKPlatformType.TypeQQ.rawValue
        ShareSDK.showShareActionSheet(view, items: [SSDKPlatformType.TypeWechat.rawValue], shareParams: shareParames) { (state, platformType, userdata, contentEnity, error, end) in
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
        coverView.frame = CGRectMake(0, 230, SCREEN_W - 6, 20)
        imageView.addSubview(coverView)
        
        nameLabel.frame = CGRectMake(11, CGFloat(imageView.frame.origin.y + 250), SCREEN_W - 30, 20)
        nameLabel.font = UIFont.boldSystemFontOfSize(22)
        //因为在屏幕尺寸比较小的情况下，dogname会出边框
        nameLabel.adjustsFontSizeToFitWidth = true
        scrollView.addSubview(nameLabel)
        
        //收藏按钮
        let button = UIButton.init(type: .System)
        button.frame = CGRectMake(SCREEN_W - 30, CGFloat(imageView.frame.origin.y + 250), 20, 20)
        button.setImage(UIImage.init(named: "726-star"), forState: .Normal)
        button.tintColor = UIColor.orangeColor()
        button.addTarget(self, action: #selector(self.collectDog(_:)), forControlEvents: .TouchUpInside)
        scrollView.addSubview(button)
        
        lable.frame = CGRectMake(10, CGFloat(imageView.frame.origin.y + 290), SCREEN_W - 20, 250)
        lable.font = UIFont.init(name: "STHeitiSC-Light", size: 17)//设置字体
        lable.textColor = TEXTGRYCOLOR
        lable.numberOfLines = 0
        lable.sizeToFit()
        scrollView.addSubview(lable)
        
        scrollView.contentSize = CGSizeMake(0, imageView.frame.height + lable.frame.height + 50 )
    }
    
    func collectDog(button:UIButton){
        //被选中
        isCollect = !isCollect
        //由于没有合适的图片作为收藏按钮，所以两张不同类型的图片，设置了线条颜色
        if isCollect {
            button.setImage(UIImage.init(named: "tab_c1")?.imageWithRenderingMode(.AlwaysOriginal), forState: .Normal)
        }else{
            button.setImage(UIImage.init(named: "726-star"), forState: .Normal)
            button.tintColor = UIColor.orangeColor()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
