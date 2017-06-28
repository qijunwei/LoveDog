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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}



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
        let tableView1 = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64-49), style: UITableViewStyle.plain)
        self.view.addSubview(tableView1)
        tableView1.delegate = self
        tableView1.dataSource = self
        let doctview = UIView.init(frame: CGRect(x: 10, y: 0, width: SCREEN_W, height: 40))
        doctview.backgroundColor = GRAYCOLOR2
        var lable11 = UILabel.init(frame: CGRect(x: 10, y: 0, width: 80, height: 40))
        lable11.text = "已选城市:"
        lable11.font = UIFont.systemFont(ofSize: 17)
        doctview.addSubview(lable11)
        self.lable1 = UILabel.init(frame: CGRect(x: 90, y: 0, width: 100, height: 40))
        self.lable1.text = self.hosCity
        self.lable1.font = UIFont.systemFont(ofSize: 17)
        let button = UIButton.init(frame: CGRect(x: SCREEN_W - 120, y: 0, width: 120, height: 40))
        button.setTitle("点击选择城市>", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.addTarget(self, action: #selector(self.citySelect), for: .touchUpInside)
        doctview.addSubview(self.lable1)
        doctview.addSubview(button)
        tableView1.tableHeaderView = doctview
        tableView1.register(HospViewCell.self, forCellReuseIdentifier: "HospViewCell")
        
        tableView1.mj_header = QFRefeshHeader.init(refreshingBlock: {
            
            let header = self.tableView1.mj_header as! MJRefreshNormalHeader
            header.setTitle("小八想你啦!", for: .idle)
            header.setTitle("小八爱你哟!", for: .pulling)
            header.setTitle("小八等你哟!", for: .refreshing)
            
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
        let tableView2 = UITableView.init(frame: CGRect(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H-64-49), style: UITableViewStyle.plain)
        self.view.addSubview(tableView2)
        tableView2.delegate = self
        tableView2.dataSource = self
        let doctview = UIView.init(frame: CGRect(x: 10, y: 0, width: SCREEN_W, height: 40))
        doctview.backgroundColor = GRAYCOLOR2
        var lable22 = UILabel.init(frame: CGRect(x: 10, y: 0, width: 80, height: 40))
        lable22.text = "已选城市:"
        lable22.font = UIFont.systemFont(ofSize: 17)
        doctview.addSubview(lable22)
        self.lable2 = UILabel.init(frame: CGRect(x: 90, y: 0, width: 100, height: 40))
        self.lable2.text = self.hosCity
        self.lable2.font = UIFont.systemFont(ofSize: 17)
        let button = UIButton.init(frame: CGRect(x: SCREEN_W - 120, y: 0, width: 120, height: 40))
        button.setTitle("点击选择城市>", for: UIControlState())
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.black, for: UIControlState())
        button.addTarget(self, action: #selector(self.citySelect), for: .touchUpInside)
        doctview.addSubview(self.lable2)
        doctview.addSubview(button)
        tableView2.tableHeaderView = doctview
        tableView2.register(DoctorViewCell.self, forCellReuseIdentifier: "DoctorViewCell")
        
        tableView2.mj_header = QFRefeshHeader.init(refreshingBlock: {
            
            let header = self.tableView2.mj_header as! MJRefreshNormalHeader
            header.setTitle("小八想你啦!", for: .idle)
            header.setTitle("小八爱你哟!", for: .pulling)
            header.setTitle("小八等你哟!", for: .refreshing)
            
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
        self.view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        self.createSegment()//分割控制器
        self.loadData1()
        self.loadData2()
        
        //        //定位
        rightItem = UIBarButtonItem.init(title: "定位", style: .plain, target:self, action: #selector(self.locateCurrent))
        rightItem?.tintColor = UIColor.black
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
        self.navigationController!.isToolbarHidden = false
        //设置间隔
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //        不管用
        //        self.navigationController!.toolbar.center = CGPointMake(SCREEN_W / 2, 22)
        
        let toolBar1 = UIBarButtonItem.init(title: "智能推荐", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.toolbarAction))
        toolBar1.tintColor = UIColor.orange
        toolBar1.tag = 101
        
        //        有问题，不按照顺序排序,  又好了
        let toolBar2 = UIBarButtonItem.init(title: "距离最近", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.toolbarAction))
        toolBar2.tag = 102
        toolBar2.tintColor = UIColor.orange
        let toolBar3 = UIBarButtonItem.init(title: "评价最高", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.toolbarAction))
        toolBar3.tag = 103
        toolBar3.tintColor = UIColor.orange
        
        toolbarItems = [spaceItem,toolBar1,spaceItem,toolBar2,spaceItem,toolBar3,spaceItem]
        
    }
    
    func toolbarAction(_ buttonItem:UIBarButtonItem){
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.segmentBtn.isHidden = false
//        创建toolbar
        self.createToolBar()
        
    }
    
    func loadData1() {
        
        HDManager.startLoading()
        HospitalModel.requestHosData(self.hosCity, page: self.page1, sort: self.sort, latitude: NSNumber.init(value: self.latitude), longitude: NSNumber.init(value: self.longtitude)) { (hospitalArray, error) in
            if error == nil
            {
                if self.page1 == 1
                {
                    self.hosArr.removeAllObjects()
                }
                
                self.hosArr.addObjects(from: hospitalArray!)
                self.tableView1.reloadData()
                self.tableView1.mj_footer.endRefreshing()
                self.tableView1.mj_header.endRefreshing()
            }
            HDManager.stopLoading()
        }
    }
    func loadData2() {
        HDManager.startLoading()
        DoctorModel.requestDocData(self.docCity, page: self.page2, sort:self.sort,latitude: NSNumber.init(value: self.latitude),longitude: NSNumber.init(value: self.longtitude)){ (doctorArray, error) in
            if error == nil
            {
                if self.page2 == 1
                {
                    self.docArr.removeAllObjects()
                }
                
                self.docArr.addObjects(from: doctorArray!)
                self.tableView2.reloadData()
                self.tableView2.mj_footer.endRefreshing()
                self.tableView2.mj_header.endRefreshing()
                
            }
            HDManager.stopLoading()
            if self.selectedIndex == 0{
                self.view.bringSubview(toFront: self.tableView1)
            }
        }
    }
    
    //创建分割控制器
    func createSegment(){
        let items = ["找医院","找医生"]
        segmentBtn = UISegmentedControl.init(items: items)
        segmentBtn.frame = CGRect(x: 100, y: 0, width: 200, height: 30)
        segmentBtn.center = CGPoint(x: SCREEN_W / 2, y: 25)
        segmentBtn.isEnabled = true
        segmentBtn.selectedSegmentIndex = 0
        segmentBtn.addTarget(self, action: #selector(self.segmentAction(_:)), for: .valueChanged)
        self.navigationController?.navigationBar.addSubview(segmentBtn)
    }
    
    //分割控制器响应方法
    func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedIndex = 0
            self.view.bringSubview(toFront: tableView1)
        default:
            selectedIndex = 1
            self.view.bringSubview(toFront: tableView2)
            break
        }
    }
    
    func citySelect(){
        let cityVc = RegionViewController()
        cityVc.delegate = self
        cityVc.hidesBottomBarWhenPushed = true
        self.segmentBtn.isHidden = true
        self.navigationController?.pushViewController(cityVc, animated: true)
    }
}

extension DogHealthViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableView1{
            return hosArr.count
        }else {
            return docArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentLocation = CLLocation.init(latitude: latitude, longitude: longtitude)
        
        if tableView == tableView1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HospViewCell", for: indexPath) as! HospViewCell
            let model = self.hosArr[(indexPath as NSIndexPath).row] as! HospitalModel
            cell.headImage.sd_setImage(with: URL.init(string: model.photo_url))
            
            let hosLocation = CLLocation.init(latitude: Double(model.latitude), longitude: Double(model.longitude))
            let dis = currentLocation.distance(from: hosLocation)/1000
            cell.disL.text = String.init(format:"%.1fkm",dis)
            
            cell.title.text = model.branch_name
            cell.address.text = "地址:" + model.address
            cell.tel.text = "联系电话:" + model.telephone
            return cell
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorViewCell", for: indexPath) as! DoctorViewCell
            let model = self.docArr[(indexPath as NSIndexPath).row] as! DoctorModel
            cell.headImage.sd_setImage(with: URL.init(string: model.avatar))
            cell.name.text = model.name
            cell.job.text = model.job
            cell.intro.text = "医生简介:" + model.introduce
            cell.hos.text = model.hospital
            
            let hosLocation = CLLocation.init(latitude: Double(model.latitude), longitude: Double(model.longitude))
            let dis = currentLocation.distance(from: hosLocation)/1000
            cell.disL.text = String.init(format:"%.1fkm",dis)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tableView1{
            return 100
        }else{
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == tableView1{
            let model = self.hosArr[(indexPath as NSIndexPath).row] as! HospitalModel
            let detailVc = HealthDetailViewController()
            detailVc.uid = String(describing: model.id)
            detailVc.flag = 0
            detailVc.hidesBottomBarWhenPushed = true
            self.segmentBtn.isHidden = true
            self.navigationController?.pushViewController(detailVc, animated: true)
            
        }else{
            let model = self.docArr[(indexPath as NSIndexPath).row] as! DoctorModel
            let detailVc = HealthDetailViewController()
            detailVc.uid = String(describing: model.uid)
            detailVc.flag = 1
            detailVc.hidesBottomBarWhenPushed = true
            self.segmentBtn.isHidden = true
            self.navigationController?.pushViewController(detailVc, animated: true)
        }
    }
}

extension DogHealthViewController:RegionViewControllerDelegate{
    func sendText(_ city: String) {
        
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
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
                print(error!)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //NSLocationWhenInUseUsageDescription
    }
}



