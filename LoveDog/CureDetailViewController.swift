//
//  CureDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class CureDetailViewController: UIViewController {

    var webView: UIWebView!
    var urlStr: String!
    var uid: String!
    var flag: NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        webView = UIWebView.init(frame: self.view.bounds)
        self.urlStr = "http://m.5ichong.com/article/detail/" + self.uid
        let url = NSURL.init(string: self.urlStr)
        let request = NSURLRequest.init(URL: url!)
        self.webView.loadRequest(request)
        self.view.addSubview(self.webView)
    }
}