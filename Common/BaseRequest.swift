//
//  BaseRequest.swift
//  PoKitchen
//
//  Created by 夏婷 on 16/7/25.
//  Copyright © 2016年 夏婷. All rights reserved.
//

import UIKit

class BaseRequest{
    
    class func getWithURL(_ url:String!,para:NSDictionary?,callBack:@escaping (_ data:Foundation.Data?,_ error:NSError?)->Void)->Void
    {
        let session = URLSession.shared
        
        let urlStr = NSMutableString.init(string: url)
        if para != nil {
//            urlStr.appendString(self.parasToString(para as! [String:String]))
            urlStr.append(self.encodeUniCode(self.parasToString(para!) as NSString) as String)
            
        }
        var request = URLRequest.init(url: (URL.init(string: urlStr as String))!)
        request.httpMethod = "GET"
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil{
                callBack(nil, error as NSError?)
                return
            }
            let res:HTTPURLResponse = response as! HTTPURLResponse
            if res.statusCode == 200
            {
                callBack(data,nil)
            }else
            {
                callBack(nil,error as NSError?)
            }
        }) 
        //启动请求任务
        dataTask .resume()
    }
    
    class func postWithURL(_ url:String!,para:NSDictionary?,callBack:@escaping (_ data:Foundation.Data?,_ error:NSError?)->Void)->Void{
        let session = URLSession.shared
        
        var urlStr = ""
        if para != nil {
            urlStr = url + self.encodeUniCode(self.parasToString(para!) as NSString)
        }
        var request = URLRequest.init(url: URL.init(string: urlStr)!)
        request.httpMethod = "POST"
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil
            {
                callBack(data,nil)
            }else
            {
                callBack(nil,error as NSError?)
            }
        }
        //启动请求任务
        dataTask.resume()
    }
    
    class func parasToString(_ para:NSDictionary?)->String
    {
        let paraStr = NSMutableString.init(string: "?")
        for (key,value) in para as! [String :String]
        {
            paraStr.appendFormat("%@=%@&", key,value)
        }
        if paraStr.hasSuffix("&"){
            paraStr.deleteCharacters(in: NSMakeRange(paraStr.length - 1, 1))
        }
        //将URL中的特殊字符进行转吗
//        paraStr.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        //移除转码
//        paraStr.stringByRemovingPercentEncoding
        return String(paraStr)
    }
    
    class func encodeUniCode(_ string:NSString) -> String
    {
        return string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
    }

    
}
