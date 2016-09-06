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
    
    class func requestData(type: NSInteger,page:NSInteger, callBack:(cureArray:[AnyObject]?,error:NSError?)->Void)->Void{
//        http://api.5ichong.com/v2.3/handbooks?limit=20&page=1&type=0
        
        let para = ["limit":"20","page":String(page),"type":String(type)]
        BaseRequest.getWithURL("http://api.5ichong.com/v2.3/handbooks", para: para) { (data, error) in
            
            if error == nil{

                //解析根目录的字典
                let obj = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                let cureArray = NSMutableArray()
                let success = obj.objectForKey("message") as! String
                if success == "成功"{
                    let dict = obj.objectForKey("data") as! NSDictionary
                    
                    let listArray = dict.objectForKey("list") as? [NSDictionary]
                    
                    let array = CuringModel.arrayOfModelsFromDictionaries(listArray)
                    cureArray.addObjectsFromArray(array as [AnyObject])
                }
                //NSURLSession发起的请求，系统会开辟一个子线程，并在子线程中去完成下载数据的任务，所有跟UI相关的操作，都应该在主线程队列中执行
                dispatch_async(dispatch_get_main_queue(), {
                    //请求成功的时候回调
                    callBack(cureArray:cureArray as [AnyObject],error:nil)
                })
                
            }else {
                //失败回调
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(cureArray: nil,error: error)
                })
            }
        }
    }
    
    
}