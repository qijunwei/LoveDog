//
//  DoctorNetworkManager.swift
//  LoveDog
//
//  Created by wei on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

extension DoctorModel {

    class func requestDocData(docCity: String, page: NSInteger, callBack:(doctorArray:[AnyObject]?,error:NSError?)->Void)->Void{
        //http://api.5ichong.com/v2.1/doctor/find_doctor_with_list?city=%E5%8C%97%E4%BA%AC&job=0&latitude=31.237787&limit=20&longitude=121.479662&page=1&sort=1
        let para = ["city":docCity,"job":"0","latitude":"31.237787","limit":"20","longitude":"121.479662","page":String(page),"sort":"2"]
        BaseRequest.getWithURL("http://api.5ichong.com/v2.1/doctor/find_doctor_with_list", para: para) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let doctorArray = NSMutableArray()
                let success = obj.objectForKey("message") as! String
                if success == "成功"{
                let dict = obj.objectForKey("data") as! NSDictionary
                
                //解析医生模型
                let listArray = dict.objectForKey("list") as? [NSDictionary]
                

                let array = DoctorModel.arrayOfModelsFromDictionaries(listArray)
                doctorArray.addObjectsFromArray(array as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                dispatch_async(dispatch_get_main_queue(), {
                    //请求成功的时候回调
                    callBack(doctorArray:doctorArray as [AnyObject],error:nil)
                })
                
            }else {
                //失败回调
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(doctorArray: nil,error: error)
                })
            }
        }
    }

}
