//
//  ShareViewController.swift
//  LoveDog
//
//  Created by wei on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
//import CoreLocation

class MainViewController: UIViewController {
    
    var tableView: UITableView!//整个页面
    var adView: XTADScrollView!//轮播视图
    var headerView: UIView!//头视图：滚动视图和五个按钮
    //定位相关
//    var locationManger : CLLocationManager!
//    //经纬度海拔 以下是算两个点的距离，放在这里记录一下
//    var longtitude:CLLocationDegrees = 0
//    var latitude:CLLocationDegrees = 0
//    var  altitude:CLLocationDistance = 0
//    
//    let currentLocation = CLLocation.init(latitude: latitude, longitude: longtitude)
//    let shopLocation = CLLocation.init(latitude: Double(model.latitude), longitude: Double(model.longitude))
//    dis = currentLocation.distanceFromLocation(shopLocation)/1000
    
    var rightItem: UIBarButtonItem?
    
    var docArr = [DoctorModel]()
    var hosArr = [HospitalModel]()
    
    
    //为主页中五个button设置的颜色
    let COLOR1 = UIColor.init(red: 249 / 255, green: 149 / 255, blue: 54 / 255, alpha: 1)
    let COLOR2 = UIColor.init(red: 121 / 255, green: 203 / 255, blue: 84 / 255, alpha: 1)
    let COLOR3 = UIColor.init(red: 167 / 255, green: 179 / 255, blue: 246 / 255, alpha: 1)
    let COLOR4 = UIColor.init(red: 149 / 255, green: 216 / 255, blue: 241 / 255, alpha: 1)
    let COLOR5 = UIColor.init(red: 233 / 255, green: 192 / 255, blue: 235 / 255, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.createTableView()
        
        let path = NSBundle.mainBundle().pathForResource("gooddoctor", ofType: "json")!
        let data = NSData.init(contentsOfFile: path)!
        let arr = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? [NSDictionary]
        for dic in arr! {
            let model = DoctorModel()
            model.avatar = dic["avatar"] as? String
            model.name = dic["name"] as? String
            model.job = dic["job"] as? String
            docArr.append(model)
        }
        
        let path1 = NSBundle.mainBundle().pathForResource("hospital", ofType: "json")!
        let data1 = NSData.init(contentsOfFile: path1)!
        let arr1 = try! NSJSONSerialization.JSONObjectWithData(data1, options: NSJSONReadingOptions.AllowFragments) as? [NSDictionary]
        for dic1 in arr1! {
            let model1 = HospitalModel()
            model1.photo_url = dic1["photo_url"] as? String
            model1.branch_name = dic1["branch_name"] as? String
            model1.address = dic1["address"] as? String
            model1.id = dic1["id"] as? NSNumber
            
            hosArr.append(model1)
        }
        
//        //定位
//        rightItem = UIBarButtonItem.init(title: "定位", style: .Plain, target:self, action: #selector(self.locateCurrent))
//        rightItem?.tintColor = UIColor.blackColor()
//        self.navigationItem.rightBarButtonItem = rightItem
        tableView.reloadData()
    }
    //    定位
//    func locateCurrent(){
//        locationManger = CLLocationManager() //位置管理器.提供位置信息和高度信息
//        locationManger.delegate = self //设代理
//        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters // 定位精度
//        locationManger.distanceFilter = 5 //500m之后更新数据
//        locationManger.requestAlwaysAuthorization() //必须发起授权
//        locationManger.requestWhenInUseAuthorization()
//        locationManger.startUpdatingLocation()
//    }
//    
    func createTableView(){
        
        tableView = UITableView.init(frame: CGRectMake(0, 64, SCREEN_W, SCREEN_H-64-49), style: UITableViewStyle.Grouped)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(HospViewCell.self, forCellReuseIdentifier: "HospViewCell")
        //头视图
        headerView = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 270))
        headerView.backgroundColor = UIColor.whiteColor()
        
        //轮播视图
        adView = XTADScrollView.init(frame: CGRectMake(0, 0, SCREEN_W, 200))
        adView.infiniteLoop = true
        adView.needPageControl = true
        adView.pageControlPositionType = pageControlPositionTypeRight
        adView.imageURLArray = ["http://b.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=779c3ac18694a4c20a76ef2d3ec437ed/cf1b9d16fdfaaf5152ca5a718d5494eef11f7ad7.jpg","http://img1.3lian.com/img13/c3/52/d/5.jpg","http://img1.3lian.com/img13/c3/52/d/14.jpg","https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1835377738,236142751&fm=206&gp=0.jpg"]
        headerView.addSubview(self.adView)
        
        //五个按钮
        let btnArr = ["细小","感冒","拉稀","绝育","脱毛"]
        let width:CGFloat = 50
        let space = CGFloat(SCREEN_W - width * 5) / 6
        
        let color = [COLOR1,COLOR2,COLOR3,COLOR4,COLOR5]
        for i in 0...4 {
            let button = UIButton.init(type: .System)
            button.frame = CGRectMake(space * CGFloat(i + 1) + width * CGFloat(i), adView.frame.origin.y + 210, width, width)
            button.setTitle(btnArr[i], forState: .Normal)
            button.backgroundColor = color[i]
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.tag = 100 + i
            button.addTarget(self, action: #selector(self.btnAction(_:)), forControlEvents: .TouchUpInside)
            button.layer.cornerRadius = 25
            headerView.addSubview(button)
        }
        
        tableView.tableHeaderView = self.headerView
    }
    
    func btnAction(button: UIButton){
        var id: String!
        let t = button.tag - 100
        if t == 0 {
            id = "37"
        }else if t == 1{
            id = "129"
        }else if t == 2{
            id = "143"
        }else if t == 3{
            id = "157"
        }else{
            id = "171"
        }
        let mainDetail = MainDetailViewController()
        mainDetail.id = id
        mainDetail.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(mainDetail, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1{
            return 1
        } else {
            //加一行：查看全部
            return 7
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0{
            var cell = tableView.dequeueReusableCellWithIdentifier("q1")
            if cell == nil{
                cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "q1")
                cell?.textLabel?.font = UIFont.systemFontOfSize(16)
                cell?.textLabel?.textColor = UIColor.blackColor()
                cell?.detailTextLabel?.textColor = UIColor.grayColor()
            }
            if  indexPath.row == 0{
                cell?.textLabel?.text = "狗狗养护手册"
                cell?.detailTextLabel?.text = "新手养宠攻略"
                cell?.imageView?.image = UIImage.init(named: "资讯")
            }else if indexPath.row == 1{
                cell?.textLabel?.text = "萌宠养护手册"
                cell?.detailTextLabel?.text = "其他萌宠攻略"
                cell?.imageView?.image = UIImage.init(named: "资讯")
            }else{
                cell?.textLabel?.text = "症状自查手册"
                cell?.detailTextLabel?.text = "典型症状自查"
                cell?.imageView?.image = UIImage.init(named: "资讯")
            }
            return cell!
        }else if section == 1 {
            let cell = DocViewCell.init(style: .Default, reuseIdentifier: "doctor", data: self.docArr)
            cell.backgroundColor = UIColor.whiteColor()
            return cell
        }else {
                //let cell = HospViewCell.init(style: .Default, reuseIdentifier: "hos")当内嵌tableview的时候用这个
                let cell = tableView.dequeueReusableCellWithIdentifier("HospViewCell", forIndexPath: indexPath) as! HospViewCell
            
            if indexPath.row != 6{
                let model = self.hosArr[indexPath.row]
                cell.headImage.sd_setImageWithURL(NSURL.init(string: model.photo_url))
                cell.title.text = model.branch_name
                cell.address.text = model.address
                cell.address.numberOfLines = 0
                cell.address.sizeToFit()
                
            }else{
                cell.seemore.text = "查看全部"
            }
                return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 50
        }else if indexPath.section == 2{
            if indexPath.row == 6{
                return 44
            }else{
                return 100
            }
        }else {
            return 140
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewS = UIView.init(frame: CGRectMake(0, 0, SCREEN_W, 50))
        viewS.backgroundColor = GRAYCOLOR2
        let label = UILabel.init(frame: CGRectMake(10, 0, SCREEN_W, 46))
        label.font = UIFont.boldSystemFontOfSize(17)
        label.textColor = BLUECOLOR2
        if section == 0 {
            label.text = "养护知识"
        }else if section == 1 {
            label.text = "宠物好医生"
        }else {
            label.text = "宠物医院"
        }
        viewS.addSubview(label)
        
        return viewS
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == 0{
            if indexPath.row == 0{
                let curingVc = CuringViewController()
                curingVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(curingVc, animated: true)
            }else if indexPath.row == 1{
                let otherVc = OtherPetsViewController()
                otherVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(otherVc, animated: true)
            }else{
                let checkVc = CheckSelfViewController()
                checkVc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(checkVc, animated: true)
            }
        }else if indexPath.section == 2 {
            
            if indexPath.row != 6 {
            let model = self.hosArr[indexPath.row]
            let detailVc = HealthDetailViewController()
            detailVc.uid = String(model.id)
            detailVc.flag = 0
            detailVc.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(detailVc, animated: true)
            }else{
                //点击查看全部，跳转到医生医院界面
                self.tabBarController!.selectedIndex = 1
            }
            
        }
    }
//   CLLocationManagerDelegate
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
////        
////        longtitude  = (location?.coordinate.longitude)! //经度 纬度 海拔
////        latitude = (location?.coordinate.latitude)!
////        altitude = (location?.altitude)!
//        
//        let geocoder = CLGeocoder.init()
//        geocoder.reverseGeocodeLocation(location!) { (array, error) in
//            if array?.count > 0{
//                let placemark = array![0]
//                //                var city = placemark.locality 直辖市及省
//                var city = placemark.subLocality
//                if city != nil {
//                    city = placemark.administrativeArea
//                }
//                self.rightItem?.title = city
//                print(city!)
//                manager.stopUpdatingLocation()
//            }else if (error == nil && array?.count == 0){
//                print("没有返回结果")
//            }else if error != nil {
//                print(error)
//            }
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        //NSLocationWhenInUseUsageDescription
//    }
}

