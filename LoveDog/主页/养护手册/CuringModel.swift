//
//  CuringModel.swift
//  LoveDog
//
//  Created by wei on 16/8/19.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import JSONModel

class CuringModel:JSONModel {
    var id : NSNumber!
    var link : String!
    var summary : String!
    var thumb : String!
    var title : String!
    
    class func requestData(_ type: NSInteger,page:NSInteger, callBack:@escaping (_ cureArray:[AnyObject]?,_ error:NSError?)->Void)->Void{
//        http://api.5ichong.com/v2.3/handbooks?limit=20&page=1&type=0
        
        let para = ["limit":"20","page":String(page),"type":String(type)]
        BaseRequest.getWithURL("http://api.5ichong.com/v2.3/handbooks", para: para as NSDictionary? as NSDictionary?) { (data, error) in
            
            if error == nil{

                //解析根目录的字典
                let obj = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let cureArray = NSMutableArray()
                let success = obj.object(forKey: "message") as! String
                if success == "成功"{
                    let dict = obj.object(forKey: "data") as! NSDictionary
                    
                    let listArray = dict.object(forKey: "list") as? [NSDictionary]
                    
                    let array = CuringModel.arrayOfModels(fromDictionaries: listArray)
                    cureArray.addObjects(from: array! as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                DispatchQueue.main.async(execute: {
                    //请求成功的时候回调
                    callBack(cureArray as [AnyObject],nil)
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
