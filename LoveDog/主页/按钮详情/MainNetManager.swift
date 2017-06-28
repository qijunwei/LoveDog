//
//  MainNetManager.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension MainModel {
    
    class func requestData1(_ id: String, callBack:@escaping (_ content:String?,_ error:NSError?)->Void)->Void{
        //http://api.5ichong.com/app.php/tag/show_tag?id=37
        
        let para = ["id":id]
        BaseRequest.getWithURL("http://api.5ichong.com/app.php/tag/show_tag", para: para as NSDictionary?) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                var content = String()
                let success = obj.object(forKey: "message") as! String
                if success == "成功"{
                    let dict = obj.object(forKey: "data") as! NSDictionary
                    content = dict["content"] as! String
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                DispatchQueue.main.async(execute: {
                    //请求成功的时候回调
                    callBack(content ,nil)
                })
                
            }else {
                //失败回调
                DispatchQueue.main.async(execute: {
                    callBack(nil,error)
                })
            }
        }
    }
    
    class func requestData2(_ id: String, callBack:@escaping (_ mainArray:[AnyObject]?,_ error:NSError?)->Void)->Void{
        //http://api.5ichong.com/app.php/tag/get_batch_article_by_tag?id=37&limit=20&page=1
        
        let para = ["id":id,"limit":"20","page":"1"]
        BaseRequest.getWithURL("http://api.5ichong.com/app.php/tag/get_batch_article_by_tag", para: para as NSDictionary?) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let mainArray = NSMutableArray()
                let success = obj.object(forKey: "message") as! String
                if success == "成功"{
                    let dict = obj.object(forKey: "data") as! NSDictionary
                    
                    let listArray = dict.object(forKey: "list") as? [NSDictionary]
                    
                    let array = MainDetailModel.arrayOfModels(fromDictionaries: listArray)
                    mainArray.addObjects(from: array! as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                DispatchQueue.main.async(execute: {
                    //请求成功的时候回调
                    callBack(mainArray as [AnyObject],nil)
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
