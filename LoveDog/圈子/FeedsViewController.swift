//
//  FeedsViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedsViewController: UIViewController,FeedCellDelegate {
    
    var page: NSInteger = 1
    var feedArr = NSMutableArray()
    
//    接收图片id的参数
    var pid : Int?
    
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
        
        cell.detailL.frame = CGRectMake(10, 60, SCREEN_W - 20, model.cellH)
        cell.detailL.text = model.content
        cell.detailL.sizeToFit()
                
        cell.dateW.text = model.createTime
        
        cell.createPhotos(model.imageUrls)
        let h = (8 + (SCREEN_W - 32) / 3) * (CGFloat(model.imageUrls.count - 1)/3 + 1)
        cell.photosView.frame = CGRectMake(10, 80 + model.cellH, SCREEN_W - 20, h)
//        cell.contentView.frame.size.height = cell.photosView.frame.size.height + cell.photosView.frame.origin.y

        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let comment = self.feedArr[indexPath.row] as! FeedModel
//        let h = (8 + ceil((SCREEN_W - 32) / 3)) * (CGFloat(comment.imageUrls.count - 1)/3 + 1)
//        ceil向上取整
        let h = (8 + (SCREEN_W - 32) / 3) * ceil(CGFloat(comment.imageUrls.count) / 3)
        return 80 + comment.cellH  + h //在模型中计算了高度
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let model = feedArr[indexPath.row]  as! FeedModel
        
        let photoView = PhotoView.init(frame: UIScreen.mainScreen().bounds)
        photoView.photo.sd_setImageWithURL(NSURL.init(string: model.imageUrls[pid!].origin))
        
        
        
    }
    
    func sendId(id: Int) {
        pid = id
    }
}



