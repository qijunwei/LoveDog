//
//  LocationCell.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
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

////iOS8之后需要在info.plist中添加NSLocationAlwaysUseageDescription和NSLocationWhenInUseUseageDescrition 字段
class LocationCell: UITableViewCell,CLLocationManagerDelegate {

    var currentcity = UILabel()
    var locationManger : CLLocationManager!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        currentcity.frame = CGRect(x: 10, y: 10, width: 260, height: 20)
        currentcity.font = UIFont.boldSystemFont(ofSize: 20)
        self.contentView.addSubview(currentcity)
        
        locationManger = CLLocationManager() //位置管理器.提供位置信息和高度信息
        locationManger.delegate = self //设代理
        locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters // 定位精度
        locationManger.distanceFilter = 500 //500m之后更新数据
        locationManger.requestWhenInUseAuthorization() //必须发起授权
        locationManger.startUpdatingLocation()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:代理
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //判断用户是否允许
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse: //用户授权可以定位
            locationManger.startUpdatingHeading()
        default:
            locationManger.stopUpdatingHeading()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        let geocoder = CLGeocoder.init()
        geocoder.reverseGeocodeLocation(location!) { (array, error) in
            if array?.count > 0{
                let placemark = array![0]
                var city = placemark.locality
                if city != nil {
                    city = placemark.administrativeArea
                }
                self.currentcity.text = city
                manager.stopUpdatingLocation()
            }else if (error == nil && array?.count == 0){
                print("没有返回结果")
            }else if error != nil {
                print(error)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //NSLocationWhenInUseUsageDescription
    }
}
