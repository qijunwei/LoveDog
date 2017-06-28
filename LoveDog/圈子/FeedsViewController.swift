//
//  FeedsViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

class FeedsViewController: UIViewController {
    
    var page: NSInteger = 0
    var feedArr = NSMutableArray()
    
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64-49), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedsCell.self, forCellReuseIdentifier: "FeedsCell")
        tableView.allowsSelection = false
        
        tableView.mj_header = QFRefeshHeader.init(refreshingBlock: {
            
            let header = self.tableView.mj_header as! MJRefreshNormalHeader
            header.setTitle("小八想你啦!", for: .idle)
            header.setTitle("小八爱你哟!", for: .pulling)
            header.setTitle("小八等你哟!", for: .refreshing)
            
            self.page = 0
            self.loadData()
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })

        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.loadData()
        
    }
    
    func loadData(){
        HDManager.startLoading()
        FeedModel.requestFeedsData(self.page) { (feedArray, error) in
            if error == nil{
                
                
                if self.page == 0
                {
                    self.feedArr.removeAllObjects()
                }
                
                self.feedArr.addObjects(from: feedArray!)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension FeedsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return feedArr.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as! FeedsCell
        
        let model = self.feedArr[(indexPath as NSIndexPath).row] as! FeedModel
        
        cell.headImage.sd_setImage(with: URL.init(string: model.creator.iconUrl.a240))
        cell.name.text = model.creator.name
        
        cell.detailL.frame = CGRect(x: 10, y: 60, width: SCREEN_W - 20, height: model.cellH)
        cell.detailL.text = model.content
        cell.detailL.sizeToFit()
                
        cell.dateW.text = model.createTime
        
        cell.createPhotos(model.imageUrls)
        cell.row = (indexPath as NSIndexPath).row
        cell.delegate = self
        
        
        let h = (8 + (SCREEN_W - 32) / 3) * (CGFloat(model.imageUrls.count - 1)/3 + 1)
        cell.photosView.frame = CGRect(x: 10, y: 80 + model.cellH, width: SCREEN_W - 20, height: h)
//        cell.contentView.frame.size.height = cell.photosView.frame.size.height + cell.photosView.frame.origin.y

        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let comment = self.feedArr[(indexPath as NSIndexPath).row] as! FeedModel
//        let h = (8 + ceil((SCREEN_W - 32) / 3)) * (CGFloat(comment.imageUrls.count - 1)/3 + 1)
//        ceil向上取整
        let h = (8 + (SCREEN_W - 32) / 3) * ceil(CGFloat(comment.imageUrls.count) / 3)
        return 80 + comment.cellH  + h //在模型中计算了高度
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

}

extension FeedsViewController:FeedsCellDelegate{
    func itemDidSelectedInRow(_ id: Int,row:Int) {
        let photoView = PhotoViewController()
        let model = self.feedArr[row] as! FeedModel
        
        photoView.photoArray = model.imageUrls
        photoView.id = id
        
//        photoView.photoView.sd_setImageWithURL(NSURL.init(string: model.imageUrls[id].a750))
        self.present(photoView, animated: false, completion: nil)
    }
}


