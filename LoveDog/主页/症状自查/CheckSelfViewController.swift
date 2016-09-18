//
//  CheckSelfViewController.swift
//  LoveDog
//
//  Created by wei on 16/9/13.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit

class CheckSelfViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var dataArr = [CheckModel]()
    var tableView: UITableView!//整个页面
    var subTable: UITableView!//次级列表
    var selectIndex = 0//选中哪一行
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "症状自查"
        self.view.backgroundColor = UIColor.whiteColor()
        
        let path = NSBundle.mainBundle().pathForResource("autognosisTags", ofType: "json")!
        let data = NSData.init(contentsOfFile: path)!
        let arr = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [NSDictionary]
        for dic in arr! {
            let model = CheckModel()
            model.name = dic["name"] as? String
            model.tags = dic["tags"] as? [String]
            dataArr.append(model)
        }
        
        self.createTableView()
        self.createSubTable()
//        让tableview第一行被选中
//        tableView.selectRowAtIndexPath(NSIndexPath.init(forRow: selectIndex, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Top)
        
////  9.0以后让左右两侧 去除边界，可以不写最后的两个方法
//        if #available(iOS 9.0, *) {
//            self.tableView.cellLayoutMarginsFollowReadableWidth = false
//        } else {
//            // Fallback on earlier versions
//        }
        
        
//        
    }
    
    func createTableView(){
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W / 3, SCREEN_H-64), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.whiteColor()
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createSubTable(){
        self.automaticallyAdjustsScrollViewInsets = false
        subTable = UITableView.init(frame: CGRectMake(SCREEN_W / 3, 64, 2 * (SCREEN_W / 3), SCREEN_H-64), style: UITableViewStyle.Plain)
        self.view.addSubview(subTable)
        subTable.showsVerticalScrollIndicator = false
        subTable.bounces = false
        subTable.delegate = self
        subTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return dataArr.count
        }else{
            return dataArr[selectIndex].tags.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.tableView{
            var cell = tableView.dequeueReusableCellWithIdentifier("Check")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "Check")
                cell?.backgroundColor = BLUECOLOR
            }
            let model = dataArr[indexPath.row]
            cell?.textLabel?.text = model.name
//            太宽的时候，字变小，挤一挤
            cell?.textLabel?.adjustsFontSizeToFitWidth = true
            
            cell?.textLabel?.textColor = UIColor.whiteColor()
            cell?.textLabel?.font = UIFont.systemFontOfSize(15)
            cell?.textLabel?.textAlignment = .Center
            return cell!
        }else{
            var cell = tableView.dequeueReusableCellWithIdentifier("sub")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCellStyle.Default, reuseIdentifier: "sub")
                
            //引导用户点击进入下一界面的图标：>
                let imageView = UIImageView.init(frame: CGRectMake(2 * SCREEN_W / 3 - 20, 15, 10, 15))
                imageView.image = UIImage.init(named: "766-arrow-right-selected")
                cell?.contentView.addSubview(imageView)
//                将默认的选中风格选为无，不然背景颜色的更改没有效果
                cell?.selectionStyle = .None
            }
            
            let model = dataArr[selectIndex].tags[indexPath.row]
            cell?.textLabel?.text = model
            cell?.textLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
            return cell!
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == self.tableView{
            return 60
        }else{
            return 50
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.tableView{
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.textColor = BLUECOLOR
        //        不管用
        //        cell?.backgroundColor = UIColor.whiteColor()
        cell?.contentView.backgroundColor = UIColor.whiteColor()
        selectIndex = indexPath.row
            subTable.reloadData()
        }else{
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            let checkDetail = CheckDetailViewController()
            checkDetail.keyWord = dataArr[selectIndex].tags[indexPath.row]
            checkDetail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(checkDetail, animated: true)
            
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.tableView{
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.textLabel?.textColor = UIColor.whiteColor()
        cell?.backgroundColor = BLUECOLOR
        }else{
            
        }
        
    }
    
//    //让tableview左右两侧的layout margin内边距变为0
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.tableView.separatorInset = UIEdgeInsetsZero
//        self.tableView.layoutMargins = UIEdgeInsetsZero
//    }
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        cell.separatorInset = UIEdgeInsetsZero
//        cell.layoutMargins = UIEdgeInsetsZero
//    }
}
