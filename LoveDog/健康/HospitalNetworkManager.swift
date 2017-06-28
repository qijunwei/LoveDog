//
//  HospitalNetworkManager.swift
//  LoveDog
//
//  Created by wei on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

extension HospitalModel {

    class func requestHosData(_ hosCity:String, page:NSInteger, sort:NSInteger,latitude:NSNumber,longitude:NSNumber,callBack:@escaping (_ hospitalArray:[AnyObject]?,_ error:NSError?)->Void)->Void{
//        http://api.5ichong.com/v1.2/hospital/find_hospital_with_region?city=%E5%8C%97%E4%BA%AC&latitude=31.237787&limit=20&longitude=121.479662&page=1&region=%E5%85%A8%E9%83%A8&sort=1
        let para = ["city":hosCity,"job":"0","latitude":String(describing: latitude),"longitude":String(describing: longitude),"region":"全部","limit":"20","page":String(page),"sort":String(sort)]
        BaseRequest.getWithURL("http://api.5ichong.com/v1.2/hospital/find_hospital_with_region", para: para as NSDictionary?) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let hospitalArray = NSMutableArray()
                let success = obj.object(forKey: "message") as! String
                if success == "成功"{
                
                let dict = obj.object(forKey: "data") as! NSDictionary
                
                //解析医生模型
                let listArray = dict.object(forKey: "list") as? [AnyObject]                
                
                let array = HospitalModel.arrayOfModels(fromDictionaries: listArray)

                hospitalArray.addObjects(from: array! as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                DispatchQueue.main.async(execute: {
                    //请求成功的时候回调
                    callBack(hospitalArray as [AnyObject],nil)
                })
                
                
            }else {
                //失败回调
                DispatchQueue.main.async(execute: {
                    callBack(nil,error)
                })
            }
        }
    }
    
}
