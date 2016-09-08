//
//  FeedsViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedsViewController: UIViewController {
    
    var page: NSInteger = 1
    var feedArr = NSMutableArray()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FeedsCell.self, forCellReuseIdentifier: "FeedsCell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false

        
        self.loadData()
        
        
    }
    
    func loadData(){
        HDManager.startLoading()
        FeedModel.requestFeedsData(1) { (feedArray, error) in
            if error == nil{
                
                self.feedArr.removeAllObjects()
                self.feedArr.addObjectsFromArray(feedArray!)
                self.tableView.reloadData()
            }
        }
        HDManager.stopLoading()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedArr.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedsCell", forIndexPath: indexPath) as! FeedsCell
        let model = self.feedArr[indexPath.row] as! FeedModel
        
        cell.headImage.sd_setImageWithURL(NSURL.init(string: model.creator.iconUrl.a240))
        cell.name.text = model.creator.name
        cell.detailL.text = model.content
        
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
}

