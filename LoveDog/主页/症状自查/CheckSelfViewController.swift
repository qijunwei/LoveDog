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
        self.view.backgroundColor = UIColor.white
        
        let path = Bundle.main.path(forResource: "autognosisTags", ofType: "json")!
        let data = try! Foundation.Data.init(contentsOf: URL(fileURLWithPath: path))
        let arr = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [NSDictionary]
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
        tableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W / 3, height: SCREEN_H-64), style: UITableViewStyle.plain)
        self.view.addSubview(tableView)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorColor = UIColor.white
        tableView.bounces = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func createSubTable(){
        self.automaticallyAdjustsScrollViewInsets = false
        subTable = UITableView.init(frame: CGRect(x: SCREEN_W / 3, y: 64, width: 2 * (SCREEN_W / 3), height: SCREEN_H-64), style: UITableViewStyle.plain)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView{
            return dataArr.count
        }else{
            return dataArr[selectIndex].tags.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView{
            var cell = tableView.dequeueReusableCell(withIdentifier: "Check")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "Check")
                cell?.backgroundColor = BLUECOLOR
            }
            let model = dataArr[(indexPath as NSIndexPath).row]
            cell?.textLabel?.text = model.name
//            太宽的时候，字变小，挤一挤
            cell?.textLabel?.adjustsFontSizeToFitWidth = true
            
            cell?.textLabel?.textColor = UIColor.white
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell?.textLabel?.textAlignment = .center
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "sub")
            if cell == nil{
                cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "sub")
                
            //引导用户点击进入下一界面的图标：>
                let imageView = UIImageView.init(frame: CGRect(x: 2 * SCREEN_W / 3 - 20, y: 15, width: 10, height: 15))
                imageView.image = UIImage.init(named: "766-arrow-right-selected")
                cell?.contentView.addSubview(imageView)
//                将默认的选中风格选为无，不然背景颜色的更改没有效果
                cell?.selectionStyle = .none
            }
            
            let model = dataArr[selectIndex].tags[(indexPath as NSIndexPath).row]
            cell?.textLabel?.text = model
            cell?.textLabel?.font = UIFont.init(name: "STHeitiSC-Light", size: 15)
            return cell!
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView{
            return 60
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = BLUECOLOR
        //        不管用
        //        cell?.backgroundColor = UIColor.whiteColor()
        cell?.contentView.backgroundColor = UIColor.white
        selectIndex = (indexPath as NSIndexPath).row
            subTable.reloadData()
        }else{
            tableView.deselectRow(at: indexPath, animated: true)
            let checkDetail = CheckDetailViewController()
            checkDetail.keyWord = dataArr[selectIndex].tags[(indexPath as NSIndexPath).row]
            checkDetail.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(checkDetail, animated: true)
            
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.tableView{
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = UIColor.white
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
