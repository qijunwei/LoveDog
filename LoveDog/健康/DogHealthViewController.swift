//
//  DogRecognizeViewController.swift
//  LoveDog
//
//  Created by qianfeng on 16/7/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh
import CoreLocation


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
    
    //定位相关
    var rightItem: UIBarButtonItem?
    var locationManger : CLLocationManager!
    var longtitude:CLLocationDegrees = 116.45729064941
    var latitude:CLLocationDegrees = 39.811630249023
    //    是什么排序
    var sort = 1
    
    lazy var tableView1:UITableView = {
        let tableView1 = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Plain)
        self.view.addSubview(tableView1)
        tableView1.delegate = self
        tableView1.dataSource = self
        let doctview = UIView.init(frame: CGRectMake(10, 0, SCREEN_W, 40))
        doctview.backgroundColor = GRAYCOLOR2
        var lable11 = UILabel.init(frame: CGRectMake(10, 3, 80, 40))
        lable11.text = "已选城市:"
        lable11.font = UIFont.systemFontOfSize(15)
        doctview.addSubview(lable11)
        self.lable1 = UILabel.init(frame: CGRectMake(90, 3, 100, 40))
        self.lable1.text = self.hosCity
        self.lable1.font = UIFont.systemFontOfSize(15)
        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 120, 3, 120, 40))
        button.setTitle("点击选择城市>", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.citySelect), forControlEvents: .TouchUpInside)
        doctview.addSubview(self.lable1)
        doctview.addSubview(button)
        tableView1.tableHeaderView = doctview
        tableView1.registerClass(HospViewCell.self, forCellReuseIdentifier: "HospViewCell")
        
        tableView1.mj_header = QFRefeshHeader.init(refreshingBlock: {
            
            let header = self.tableView1.mj_header as! MJRefreshNormalHeader
            header.setTitle("小八想你啦!", forState: .Idle)
            header.setTitle("小八爱你哟!", forState: .Pulling)
            header.setTitle("小八等你哟!", forState: .Refreshing)
            
            self.page1 = 1
            self.loadData1()
        })
        
        tableView1.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
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
        let doctview = UIView.init(frame: CGRectMake(10, 0, SCREEN_W, 40))
        doctview.backgroundColor = GRAYCOLOR2
        var lable22 = UILabel.init(frame: CGRectMake(10, 3, 80, 40))
        lable22.text = "已选城市:"
        lable22.font = UIFont.systemFontOfSize(15)
        doctview.addSubview(lable22)
        self.lable2 = UILabel.init(frame: CGRectMake(90, 3, 100, 40))
        self.lable2.text = self.hosCity
        self.lable2.font = UIFont.systemFontOfSize(15)
        let button = UIButton.init(frame: CGRectMake(SCREEN_W - 120, 3, 120, 40))
        button.setTitle("点击选择城市>", forState: .Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: #selector(self.citySelect), forControlEvents: .TouchUpInside)
        doctview.addSubview(self.lable2)
        doctview.addSubview(button)
        tableView2.tableHeaderView = doctview
        tableView2.registerClass(DoctorViewCell.self, forCellReuseIdentifier: "DoctorViewCell")
        
        tableView2.mj_header = QFRefeshHeader.init(refreshingBlock: {
            
            let header = self.tableView2.mj_header as! MJRefreshNormalHeader
            header.setTitle("小八想你啦!", forState: .Idle)
            header.setTitle("小八爱你哟!", forState: .Pulling)
            header.setTitle("小八等你哟!", forState: .Refreshing)
            
            self.page2 = 1
            self.loadData2()
        })
        
        tableView2.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
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
        
        //        //定位
        rightItem = UIBarButtonItem.init(title: "定位", style: .Plain, target:self, action: #selector(self.locateCurrent))
        rightItem?.tintColor = UIColor.blackColor()
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    //    定位
    func locateCurrent(){
        locationManger = CLLocationManager() //位置管理器.提供位置信息和高度信息
        locationManger.delegate = self //设代理
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters // 定位精度
        locationManger.distanceFilter = 5 //500m之后更新数据
        locationManger.requestAlwaysAuthorization() //必须发起授权
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    
    func createToolBar(){
        self.navigationController!.toolbarHidden = false
        //设置间隔
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        //        不管用
        //        self.navigationController!.toolbar.center = CGPointMake(SCREEN_W / 2, 22)
        
        let toolBar1 = UIBarButtonItem.init(title: "智能推荐", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.toolbarAction))
        toolBar1.tintColor = UIColor.orangeColor()
        toolBar1.tag = 101
        
        //        有问题，不按照顺序排序,  又好了
        let toolBar2 = UIBarButtonItem.init(title: "距离最近", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.toolbarAction))
        toolBar2.tag = 102
        toolBar2.tintColor = UIColor.orangeColor()
        let toolBar3 = UIBarButtonItem.init(title: "评价最高", style: UIBarButtonItemStyle.Done, target: self, action: #selector(self.toolbarAction))
        toolBar3.tag = 103
        toolBar3.tintColor = UIColor.orangeColor()
        
        toolbarItems = [spaceItem,toolBar1,spaceItem,toolBar2,spaceItem,toolBar3,spaceItem]
        
    }
    
    func toolbarAction(buttonItem:UIBarButtonItem){
        if buttonItem.tag == 101 {
            sort = 1
            if selectedIndex == 0 {
                self.loadData1()
            }else{
                self.loadData2()
            }
        }else if buttonItem.tag == 102 {
            sort = 2
            if selectedIndex == 0 {
                self.loadData1()
            }else{
                self.loadData2()
            }
        }else{
            sort = 3
            if selectedIndex == 0 {
                self.loadData1()
            }else{
                self.loadData2()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.segmentBtn.hidden = false
//        创建toolbar
        self.createToolBar()
        
    }
    
    func loadData1() {
        
        HDManager.startLoading()
        HospitalModel.requestHosData(self.hosCity, page: self.page1, sort:self.sort,latitude: self.latitude,longitude: self.longtitude){ (hospitalArray, error) in
            if error == nil
            {
                if self.page1 == 1
                {
                    self.hosArr.removeAllObjects()
                }
                
                self.hosArr.addObjectsFromArray(hospitalArray!)
                self.tableView1.reloadData()
                self.tableView1.mj_footer.endRefreshing()
                self.tableView1.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    func loadData2() {
        HDManager.startLoading()
        DoctorModel.requestDocData(self.docCity, page: self.page2, sort:self.sort,latitude: self.latitude,longitude: self.longtitude){ (doctorArray, error) in
            if error == nil
            {
                if self.page2 == 1
                {
                    self.docArr.removeAllObjects()
                }
                
                self.docArr.addObjectsFromArray(doctorArray!)
                self.tableView2.reloadData()
                self.tableView2.mj_footer.endRefreshing()
                self.tableView2.mj_header.endRefreshing()
                
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
        
        let currentLocation = CLLocation.init(latitude: latitude, longitude: longtitude)
        
        if tableView == tableView1{
            let cell = tableView.dequeueReusableCellWithIdentifier("HospViewCell", forIndexPath: indexPath) as! HospViewCell
            let model = self.hosArr[indexPath.row] as! HospitalModel
            cell.headImage.sd_setImageWithURL(NSURL.init(string: model.photo_url))
            
            let hosLocation = CLLocation.init(latitude: Double(model.latitude), longitude: Double(model.longitude))
            print(currentLocation,model.longitude,model.latitude)
            let dis = currentLocation.distanceFromLocation(hosLocation)/1000
            cell.disL.text = String.init(format:"%.1fkm",dis)
            
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
            
            let hosLocation = CLLocation.init(latitude: Double(model.latitude), longitude: Double(model.longitude))
            let dis = currentLocation.distanceFromLocation(hosLocation)/1000
            cell.disL.text = String.init(format:"%.1fkm",dis)
            
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

extension DogHealthViewController:CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        longtitude  = (location?.coordinate.longitude)! //经度 纬度 海拔
        latitude = (location?.coordinate.latitude)!
        
        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(location!) { (array, error) in
            if array?.count > 0{
                let placemark = array![0]
                //                var city = placemark.locality 直辖市及省
                var city = placemark.subLocality
                if city != nil {
                    city = placemark.administrativeArea
                }
                self.rightItem?.title = city
                print(city!)
                manager.stopUpdatingLocation()
            }else if (error == nil && array?.count == 0){
                print("没有返回结果")
            }else if error != nil {
                print(error)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        //NSLocationWhenInUseUsageDescription
    }
}



