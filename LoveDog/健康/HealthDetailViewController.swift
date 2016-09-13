//
//  HealthDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/17.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class HealthDetailViewController: UIViewController {

    var webView: UIWebView!
    var urlStr: String!
    var uid: String!
    var flag: NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        webView = UIWebView.init(frame: self.view.bounds)
        if self.flag == 0{
            self.urlStr = "http://m.5ichong.com/hospital/" + self.uid
        }else {
            self.urlStr = "http://m.5ichong.com/doctor/" + self.uid
        }
        
        let url = NSURL.init(string: self.urlStr)
        let request = NSURLRequest.init(URL: url!)
        self.webView.loadRequest(request)
        self.view.addSubview(self.webView)
        
//        隐藏toolbar
        self.navigationController!.toolbarHidden = true

    }
    
}
