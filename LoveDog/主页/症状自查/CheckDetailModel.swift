//
//  CheckDetailModel.swift
//  LoveDog
//
//  Created by wei on 16/9/13.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import SwiftyJSON

extension CheckDetailModel {
    //http://api.5ichong.com/v2.3/diagnosis?keyword=%E5%91%95%E5%90%90
    class func requestCheckData(keyword:String,callBack:(checkArray:[AnyObject]?,error:NSError?)->Void)->Void{
        
        let para = ["keyword":keyword]
        BaseRequest.getWithURL("http://api.5ichong.com/v2.3/diagnosis", para: para) { (data, error) in
            
            let checkArray = NSMutableArray()
            if error == nil{
                let json = JSON(data: data!)
                if json["message"] == "成功" {
                    let array = json["data"]["list"].arrayValue
                    for subjson in array {
                        let model = List.init(fromJson: subjson)
                        checkArray.addObject(model)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), {
                    //请求成功的时候回调
                    callBack(checkArray:checkArray as [AnyObject],error:nil)
                })
            }else{
                //失败回调
                dispatch_async(dispatch_get_main_queue(), {
                    callBack(checkArray: nil,error: error)
                })
            }
            
        }
        
    }
    
    
}



class CheckDetailModel{
    
    var data : Data!
    var message : String!
    var status : Int!
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        let dataJson = json["data"]
        if dataJson != JSON.null{
            data = Data(fromJson: dataJson)
        }
        message = json["message"].stringValue
        status = json["status"].intValue
    }
    
}


class Data{
    
    var keyword : String!
    var list : [List]!
    var tags : Tag!
    
    
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        keyword = json["keyword"].stringValue
        list = [List]()
        let listArray = json["list"].arrayValue
        for listJson in listArray{
            let value = List(fromJson: listJson)
            list.append(value)
        }
        let tagsJson = json["tags"]
        if tagsJson != JSON.null{
            tags = Tag(fromJson: tagsJson)
        }
    }
    
}

class Tag{
    
    var a0 : String!
    var a1 : String!
    var a10 : String!
    var a13 : String!
    var a2 : String!
    var a3 : String!
    var a4 : String!
    var a5 : String!
    var a6 : String!
    var a7 : String!
    var a9 : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        a0 = json["0"].stringValue
        a1 = json["1"].stringValue
        a10 = json["10"].stringValue
        a13 = json["13"].stringValue
        a2 = json["2"].stringValue
        a3 = json["3"].stringValue
        a4 = json["4"].stringValue
        a5 = json["5"].stringValue
        a6 = json["6"].stringValue
        a7 = json["7"].stringValue
        a9 = json["9"].stringValue
    }
    
}

class List{
    
    var define : String!
    var id : Int!
    var name : String!
    var tags : String!
    var tagsTotal : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        define = json["define"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        tags = json["tags"].stringValue
        tagsTotal = json["tags_total"].intValue
    }
    
    
//    计算高度
    //计算显示的评论内容
    var attr:NSMutableAttributedString!{
        var atrSring:NSMutableAttributedString? = nil
        let content:NSMutableString = NSMutableString.init(string: "")
        content.appendString(self.define)
        atrSring = NSMutableAttributedString.init(string: content as String)
        return atrSring!
    }
    var cellH :CGFloat{
        //给定一个尺寸，宽、高计算一个字符串的大小
        let str = NSString.init(string: self.attr.string)
        
        let rect = str.boundingRectWithSize(CGSizeMake(SCREEN_W - 20, 99999), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.init(name: "STHeitiSC-Light", size: 15)!], context: nil)
        return rect.size.height
    }
    
}