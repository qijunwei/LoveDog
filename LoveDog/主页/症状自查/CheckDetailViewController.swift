//
//  CheckDetailViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/13.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class CheckDetailViewController: UIViewController {

    var keyWord:String?
    
    var dataArr = NSMutableArray()
    var tableView: UITableView!//整个页面
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.keyWord
        self.view.backgroundColor = UIColor.whiteColor()
        self.createTableView()
        self.loadData()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorColor = UIColor.whiteColor()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func loadData() {
        
        HDManager.startLoading()
        CheckDetailModel.requestCheckData(self.keyWord!) { (checkArray, error) in
            if error == nil{

                self.dataArr.removeAllObjects()
                self.dataArr.addObjectsFromArray(checkArray!)
                self.tableView.reloadData()

            }
                HDManager.stopLoading()
        }
    }
}


extension CheckDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("detail")
        if cell == nil{
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "detail")
        }
        
        let model = self.dataArr[indexPath.row] as! List
        
        cell?.textLabel?.text = "●" + model.name
        cell?.textLabel?.font = UIFont.boldSystemFontOfSize(17)
        
        cell?.detailTextLabel?.text = model.define
        cell?.detailTextLabel?.numberOfLines = 0
        cell?.detailTextLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
        
        return cell!
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let comment = self.dataArr[indexPath.row] as! List
        return 60 + comment.cellH//在模型中计算了高度
    }

}
