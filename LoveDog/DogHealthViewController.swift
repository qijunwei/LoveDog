//
//  DogRecognizeViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class DogHealthViewController: UIViewController {

    var segmentBtn: UISegmentedControl!
    var lable1:UILabel!
    var lable2:UILabel!
    var page1: NSInteger = 1
    var page2: NSInteger = 1
    var hosArr = NSMutableArray()
    var docArr = NSMutableArray()
    var selectedIndex = 0
    var docCity = "北京"
    var hosCity = "北京"
    
    lazy var tableView1:UITableView = {
        let tableView1 = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView1)
        tableView1.delegate = self
        tableView1.dataSource = self
        let doctview = UIView.init(frame: CGRectMake(10, 0, SCREEN_W, 50))
        doctview.backgroundColor = GRAYCOLOR2
        var lable11 = UILabel.init(frame: CGRectMake(10, 5, 80, 50))
        lable11.text = "已选城市:"
        lable11.font = UIFont.systemFontOfSize(18)
        doctview.addSubview(lable11)
        self.lable1 = UILabel.init(frame: CGRectMake(90, 5, 100, 50))
        self.lable1.text = self.hosCity
        self.lable1.font = UIFont.systemFontOfSize(18)
        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 120, 5, 120, 50))
        button.setTitle("点击选择城市>", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.citySelect), forControlEvents: .TouchUpInside)
        doctview.addSubview(self.lable1)
        doctview.addSubview(button)
        tableView1.tableHeaderView = doctview
        tableView1.registerClass(HospViewCell.self, forCellReuseIdentifier: "HospViewCell")
        
        tableView1.header = QFRefeshHeader.init(refreshingBlock: {
            self.page1 = 1
            self.loadData1()
        })
        
        tableView1.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page1 += 1
            self.loadData1()
        })
        
        return tableView1
    }()
    
    lazy var tableView2:UITableView = {
        let tableView2 = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView2)
        tableView2.delegate = self
        tableView2.dataSource = self
        let doctview = UIView.init(frame: CGRectMake(10, 0, SCREEN_W, 50))
        doctview.backgroundColor = GRAYCOLOR2
        var lable22 = UILabel.init(frame: CGRectMake(10, 5, 80, 50))
        lable22.text = "已选城市:"
        lable22.font = UIFont.systemFontOfSize(18)
        doctview.addSubview(lable22)
        self.lable2 = UILabel.init(frame: CGRectMake(90, 5, 100, 50))
        self.lable2.text = self.hosCity
        self.lable2.font = UIFont.systemFontOfSize(18)
        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 120, 5, 120, 50))
        button.setTitle("点击选择城市>", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.citySelect), forControlEvents: .TouchUpInside)
        doctview.addSubview(self.lable2)
        doctview.addSubview(button)
        tableView2.tableHeaderView = doctview
        tableView2.registerClass(DoctorViewCell.self, forCellReuseIdentifier: "DoctorViewCell")
        
        tableView2.header = QFRefeshHeader.init(refreshingBlock: {
            self.page2 = 1
            self.loadData2()
        })
        
        tableView2.footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
            self.page2 += 1
            self.loadData2()
        })
        
        return tableView2
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.createSegment()//分割控制器
        self.loadData1()
        self.loadData2()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.segmentBtn.hidden = false

    }
    
    func loadData1() {
        
        HDManager.startLoading()
        HospitalModel.requestHosData(self.hosCity, page: self.page1){ (hospitalArray, error) in
            if error == nil
            {
                if self.page1 == 1
                {
                    self.hosArr.removeAllObjects()
                }
                
                self.hosArr.addObjectsFromArray(hospitalArray!)
                self.tableView1.reloadData()
                self.tableView1.footer.endRefreshing()
                self.tableView1.header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    func loadData2() {
        HDManager.startLoading()
        DoctorModel.requestDocData(self.docCity, page: self.page2){ (doctorArray, error) in
            if error == nil
            {
                if self.page2 == 1
                {
                    self.docArr.removeAllObjects()
                }
                
                self.docArr.addObjectsFromArray(doctorArray!)
                self.tableView2.reloadData()
                self.tableView2.footer.endRefreshing()
                self.tableView2.header.endRefreshing()

            }
            HDManager.stopLoading()
            if self.selectedIndex == 0{
                self.view.bringSubviewToFront(self.tableView1)
            }
        }
    }
    
    //创建分割控制器
    func createSegment(){
        let items = ["找医院","找医生"]
        segmentBtn = UISegmentedControl.init(items: items)
        segmentBtn.frame = CGRectMake(100, 0, 200, 30)
        segmentBtn.center = CGPointMake(SCREEN_W / 2, 25)
        segmentBtn.enabled = true
        segmentBtn.selectedSegmentIndex = 0
        segmentBtn.addTarget(self, action: #selector(self.segmentAction(_:)), forControlEvents: .ValueChanged)
        self.navigationController?.navigationBar.addSubview(segmentBtn)
    }
    
    //分割控制器响应方法
    func segmentAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedIndex = 0
            self.view.bringSubviewToFront(tableView1)
        default:
            selectedIndex = 1
            self.view.bringSubviewToFront(tableView2)
            break
        }
    }
    
    func citySelect(){
        let cityVc = RegionViewController()
        cityVc.delegate = self
        cityVc.hidesBottomBarWhenPushed = true
        self.segmentBtn.hidden = true
        self.navigationController?.pushViewController(cityVc, animated: true)
    }
}

extension DogHealthViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
        return hosArr.count
        }else {
            return docArr.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == tableView1{
            let cell = tableView.dequeueReusableCellWithIdentifier("HospViewCell", forIndexPath: indexPath) as! HospViewCell
            let model = self.hosArr[indexPath.row] as! HospitalModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.photo_url))
            cell.title.text = model.branch_name
            cell.address.text = "地址:" + model.address
            cell.tel.text = "联系电话:" + model.telephone
            return cell
        }else {

            let cell = tableView.dequeueReusableCellWithIdentifier("DoctorViewCell", forIndexPath: indexPath) as! DoctorViewCell
            let model = self.docArr[indexPath.row] as! DoctorModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.avatar))
            cell.name.text = model.name
            cell.job.text = model.job
            cell.intro.text = "医生简介:" + model.introduce
            cell.hos.text = model.hospital
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView == tableView1{
            return 100
        }else{
            return 110
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if tableView == tableView1{
            let model = self.hosArr[indexPath.row] as! HospitalModel
            let detailVc = HealthDetailViewController()
            detailVc.uid = String(model.id)
            detailVc.flag = 0
            detailVc.hidesBottomBarWhenPushed = true
            self.segmentBtn.hidden = true
            self.navigationController?.pushViewController(detailVc, animated: true)

        }else{
            let model = self.docArr[indexPath.row] as! DoctorModel
            let detailVc = HealthDetailViewController()
            detailVc.uid = String(model.uid)
            detailVc.flag = 1
            detailVc.hidesBottomBarWhenPushed = true
            self.segmentBtn.hidden = true
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}

extension DogHealthViewController:RegionViewControllerDelegate{
    func sendText(city: String) {
        
        if self.selectedIndex == 0{
            self.hosCity = city
            self.lable1.text = city
            self.page1 = 1
            self.loadData1()
        }else {
            self.docCity = city
            self.lable2.text = city
            self.page2 = 1
            self.loadData2()
        }
    }
}
