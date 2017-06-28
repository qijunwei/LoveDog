//
//  AppDelegate.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //设置新的window
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.backgroundColor = UIColor.white
        
        //将标签栏设置为window的根视图
        let dogTabBarCtl = DogTabBarController()
        window?.rootViewController = dogTabBarCtl
        
        //设置启动页的时间
        Thread.sleep(forTimeInterval: 1)
        
        window?.makeKeyAndVisible()
        
        //初始化第三方分享登录平台
        shareQQAndWechat()
        
        return true
    }

    func shareQQAndWechat(){
        //初始化SDK、初始化三方平台,SDK和三方平台的SDK建立一个连接，需要的时候就触发
        ShareSDK.registerActivePlatforms([SSDKPlatformType.typeWechat.rawValue,SSDKPlatformType.typeQQ.rawValue], onImport: { (platformType) in
            switch platformType {
            case SSDKPlatformType.typeWechat:
                ShareSDKConnector.connectWeChat(WXApi.classForCoder())
//            case SSDKPlatformType.TypeQQ:
//                ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
            default:
                break
            }
        }) { (platformType, appInfo) in
            switch platformType {
            case SSDKPlatformType.typeWechat:
                appInfo?.ssdkSetupWeChat(byAppId: wechatAppID, appSecret: wechatAppSecret)
//            case SSDKPlatformType.TypeQQ:
//                appInfo.SSDKSetupQQByAppId(QQAppId, appKey: QQAppKey, authType: SSDKAuthTypeSSO)
            default:
                break
            }
        }

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

