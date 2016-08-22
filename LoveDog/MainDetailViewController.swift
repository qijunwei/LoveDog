//
//  MainDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MainDetailViewController: UIViewController {
    
    var id: String!
    var lable = UILabel()
    var dataArr = NSMutableArray()
    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(MainDetailCell.self, forCellReuseIdentifier: "MainDetailCell")
        let view = UIView.init(frame: CGRectMake(0, 0, SCREEN_W , 120))
        self.lable.frame = CGRectMake(10, 0, SCREEN_W - 30, 120)
        view.addSubview(self.lable)
        
        tableView.tableHeaderView = view
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
        self.loadData()
    }
    
    func loadData() {
        
        HDManager.startLoading()
        MainModel.requestData1(self.id){ (content, error) in
            if error == nil
            {
                self.lable.text = content
                self.lable.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
                self.lable.numberOfLines = 5
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
        MainModel.requestData2(self.id){ (array, error) in
            if error == nil{
                self.dataArr.removeAllObjects()
                self.dataArr.addObjectsFromArray(array!)
                self.tableView.reloadData()
            }
            HDManager.stopLoading()
        }
    }
}

extension MainDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MainDetailCell", forIndexPath: indexPath) as! MainDetailCell
        let model = self.dataArr[indexPath.row] as! MainDetailModel
        cell.image1.sd_setImageWithURL(NSURL.init(string: model.thumb))
        cell.title.text = model.title
        cell.good.text = String(model.up) + "人觉得有用"
        return cell
    }
    
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let model = self.dataArr[indexPath.row] as! MainDetailModel
        let mainVc = MainWebviewViewController()
        mainVc.uid = String(model.id)
        mainVc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mainVc, animated: true)
    }
}

