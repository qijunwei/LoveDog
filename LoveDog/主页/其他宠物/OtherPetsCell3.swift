//
//  OtherPetsCell.swift
//  LoveDog
//
//  Created by wei on 16/9/6.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import MJRefresh

class OtherPetsCell3: UICollectionViewCell,UITableViewDelegate,UITableViewDataSource {
    
    weak var delegate:OtherPetsViewControllerDelegate?

    var page: NSInteger = 1
    var lable = UILabel()
    var dataArr = NSMutableArray()
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 0, SCREEN_W, SCREEN_H-64), style: UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(CuringCell.self, forCellReuseIdentifier: "CuringCell")
        self.contentView.addSubview(tableView)
        
        tableView.mj_header = QFRefeshHeader.init(refreshingBlock: {
            self.page = 1
            self.loadData()
        })
        
        tableView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page += 1
            self.loadData()
        })
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = GRAYCOLOR
        self.loadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        
        HDManager.startLoading()
        CuringModel.requestData(4,page: self.page){ (array, error) in
            if error == nil{
                
                if self.page == 1
                {
                    self.dataArr.removeAllObjects()
                }
                
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
                self.tableView.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CuringCell", forIndexPath: indexPath) as! CuringCell
        let model = self.dataArr[indexPath.row] as! CuringModel
        cell.image1.sd_setImageWithURL(NSURL.init(string: model.thumb))
        cell.title.text = model.title
        cell.summary.text = model.summary
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cureVc = CureDetailViewController()
        let model = self.dataArr[indexPath.row] as! CuringModel
        cureVc.uid = String(model.id)
        
        cureVc.hidesBottomBarWhenPushed = true
        self.delegate?.pushToViewController(cureVc)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }

}
