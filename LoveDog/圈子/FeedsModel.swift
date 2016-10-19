//
//  FeedsModel.swift
//  LoveDog
//
//  Created by wei on 16/9/7.
//  Copyright © 2016年 wei. All rights reserved.
//

import UIKit
import SwiftyJSON

extension FeedModel{
    
//    http://api.wsq.umeng.com/v2/feeds/stream?os=iOS&ak=5587b6d167e58e151a0056be&count=20&anonymous=1&sdkv=2.2.1&openudidopenudid=3a0f9c6a417b25a73457a925e96602b279cc8c25 start=20
    
    class func requestFeedsData(_ page: NSInteger, callBack:@escaping (_ feedArray:[AnyObject]?,_ error:NSError?)->Void)->Void{
    
        let start = String(20 * page)
        let para = ["os":"iOS","ak":"5587b6d167e58e151a0056be","count":"20","anonymous":"1","sdkv":"2.2.1","openudidopenudid":"3a0f9c6a417b25a73457a925e96602b279cc8c25","start":start]
        BaseRequest.getWithURL("http://api.wsq.umeng.com/v2/feeds/stream", para: para as NSDictionary?) { (data, error) in
            
            if error == nil{
                let json = JSON(data: data!)
                let feedArray = NSMutableArray()
                let array = json["items"].arrayValue
                for subjson in array {
                    let model = FeedModel.init(fromJson: subjson)
                    feedArray.add(model)
                }
                DispatchQueue.main.async(execute: {
                    //请求成功的时候回调
                    callBack(feedArray as [AnyObject],nil)
                })
            }else{
                //失败回调
                DispatchQueue.main.async(execute: {
                    callBack(nil,error)
                })
            }
        
        }

    }
    
    //计算显示的评论内容
    var attr:NSMutableAttributedString!{
        var atrSring:NSMutableAttributedString? = nil
        let content:NSMutableString = NSMutableString.init(string: "")
            content.append(self.content)
            atrSring = NSMutableAttributedString.init(string: content as String)
            return atrSring!
    }
    var cellH :CGFloat{
        //给定一个尺寸，宽、高计算一个字符串的大小
        let str = NSString.init(string: self.attr.string)
        
        let rect = str.boundingRect(with: CGSize(width: SCREEN_W - 20, height: 99999), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 15)], context: nil)
        return rect.size.height
    }
}



class FeedModel{
    
    var banUser : Bool!
    var commentsCount : Int!
    var content : String!
    var createTime : String!
    var creator : Creator!
    var custom : String!
    var forwardCount : Int!
    var hasCollected : Bool!
    var id : String!
    var imageUrls : [ImageUrl]!
    var isRecommended : Bool!
    var isTop : Int!
    var isTopicTop : AnyObject!
    var liked : Bool!
    var likesCount : Int!
    var location : AnyObject!
    var mediaInfo : [AnyObject]!
    var mediaType : Int!
    var originFeed : [AnyObject]!
    var parentFeedId : String!
    var permission : Int!
    var relatedUser : [AnyObject]!
    var richText : String!
    var richTextUrl : String!
    var seq : Int!
    var shareLink : String!
    var status : Int!
    var tag : Int!
    var title : String!
    var topics : [AnyObject]!
    var type : Int!
    var userMark : Int!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        banUser = json["ban_user"].boolValue
        commentsCount = json["comments_count"].intValue
        content = json["content"].stringValue
        createTime = json["create_time"].stringValue
        let creatorJson = json["creator"]
        if creatorJson != JSON.null{
            creator = Creator(fromJson: creatorJson)
        }
        custom = json["custom"].stringValue
        forwardCount = json["forward_count"].intValue
        hasCollected = json["has_collected"].boolValue
        id = json["id"].stringValue
        imageUrls = [ImageUrl]()
        let imageUrlsArray = json["image_urls"].arrayValue
        for imageUrlsJson in imageUrlsArray{
            let value = ImageUrl(fromJson: imageUrlsJson)
            imageUrls.append(value)
        }
        isRecommended = json["is_recommended"].boolValue
        isTop = json["is_top"].intValue
        isTopicTop = json["is_topic_top"].stringValue as AnyObject!
        liked = json["liked"].boolValue
        likesCount = json["likes_count"].intValue
        location = json["location"].stringValue as AnyObject!
        mediaInfo = [AnyObject]()
        let mediaInfoArray = json["media_info"].arrayValue
        for mediaInfoJson in mediaInfoArray{
            mediaInfo.append(mediaInfoJson.stringValue as AnyObject)
        }
        mediaType = json["media_type"].intValue
        originFeed = [AnyObject]()
        let originFeedArray = json["origin_feed"].arrayValue
        for originFeedJson in originFeedArray{
            originFeed.append(originFeedJson.stringValue as AnyObject)
        }
        parentFeedId = json["parent_feed_id"].stringValue
        permission = json["permission"].intValue
        relatedUser = [AnyObject]()
        let relatedUserArray = json["related_user"].arrayValue
        for relatedUserJson in relatedUserArray{
            relatedUser.append(relatedUserJson.stringValue as AnyObject)
        }
        richText = json["rich_text"].stringValue
        richTextUrl = json["rich_text_url"].stringValue
        seq = json["seq"].intValue
        shareLink = json["share_link"].stringValue
        status = json["status"].intValue
        tag = json["tag"].intValue
        title = json["title"].stringValue
        topics = [AnyObject]()
        let topicsArray = json["topics"].arrayValue
        for topicsJson in topicsArray{
            topics.append(topicsJson.stringValue as AnyObject)
        }
        type = json["type"].intValue
        userMark = json["user_mark"].intValue
    }
}



class ImageUrl{
    
    var a360 : String!
    var a750 : String!
    var origin : String!
    var phone : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        a360 = json["360"].stringValue
        a750 = json["750"].stringValue
        origin = json["origin"].stringValue
        phone = json["phone"].stringValue
    }
}


class Creator{
    
    var atype : Int!
    var custom : String!
    var gender : Int!
    var hasFollowed : Bool!
    var iconUrl : IconUrl!
    var id : String!
    var level : Int!
    var medalList : [AnyObject]!
    var name : String!
    var relation : Int!
    var sourceUid : String!
    var status : Int!
    

    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        atype = json["atype"].intValue
        custom = json["custom"].stringValue
        gender = json["gender"].intValue
        hasFollowed = json["has_followed"].boolValue
        let iconUrlJson = json["icon_url"]
        if iconUrlJson != JSON.null{
            iconUrl = IconUrl(fromJson: iconUrlJson)
        }
        id = json["id"].stringValue
        level = json["level"].intValue
        medalList = [AnyObject]()
        let medalListArray = json["medal_list"].arrayValue
        for medalListJson in medalListArray{
            medalList.append(medalListJson.stringValue as AnyObject)
        }
        name = json["name"].stringValue
        relation = json["relation"].intValue
        sourceUid = json["source_uid"].stringValue
        status = json["status"].intValue
    }
}



class IconUrl{
    
    var a240 : String!
    var a640 : String!
    var origin : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json == nil{
            return
        }
        a240 = json["240"].stringValue
        a640 = json["640"].stringValue
        origin = json["origin"].stringValue
    }
    
}
