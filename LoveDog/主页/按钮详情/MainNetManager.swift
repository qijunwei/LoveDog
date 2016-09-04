//
//  MainNetManager.swift
//  LoveDog
//
//  Created by wei on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation

extension MainModel {
    
    class func requestData1(id: String, callBack:(content:String?,error:NSError?)->Void)->Void{
        //http://api.5ichong.com/app.php/tag/show_tag?id=37
        
        let para = ["id":id]
        BaseRequest.getWithURL("http://api.5ichong.com/app.php/tag/show_tag", para: para) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                var content = String()
                let success = obj.objectForKey("message") as! String
                if success == "成功"{
                    let dict = obj.objectForKey("data") as! NSDictionary
                    content = dict["content"] as! String
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                dispatch_async(dispatch_get_main_queue(), {
                    //请求成功的时候回调
                    callBack(content:content ,error:nil)
                })
                
            }else {
                //失败回调
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(content: nil,error: error)
                })
            }
        }
    }
    
    class func requestData2(id: String, callBack:(mainArray:[AnyObject]?,error:NSError?)->Void)->Void{
        //http://api.5ichong.com/app.php/tag/get_batch_article_by_tag?id=37&limit=20&page=1
        
        let para = ["id":id,"limit":"20","page":"1"]
        BaseRequest.getWithURL("http://api.5ichong.com/app.php/tag/get_batch_article_by_tag", para: para) { (data, error) in
            
            if error == nil{
                //解析根目录的字典
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let mainArray = NSMutableArray()
                let success = obj.objectForKey("message") as! String
                if success == "成功"{
                    let dict = obj.objectForKey("data") as! NSDictionary
                    
                    let listArray = dict.objectForKey("list") as? [NSDictionary]
                    
                    let array = MainDetailModel.arrayOfModelsFromDictionaries(listArray)
                    mainArray.addObjectsFromArray(array as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                dispatch_async(dispatch_get_main_queue(), {
                    //请求成功的时候回调
                    callBack(mainArray:mainArray as [AnyObject],error:nil)
                })
                
            }else {
                //失败回调
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(mainArray: nil,error: error)
                })
            }
        }
    }    
}