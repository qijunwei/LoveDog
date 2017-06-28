//
//  ShareModel.swift
//  LoveDog
//
//  Created by wei on 16/8/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import JSONModel

class MainModel:JSONModel {
    var content: String!
    var id:String!
    var name:String!
}

class MainDetailModel:JSONModel {
    var author : String!
    var created : NSNumber!
    var down : NSNumber!
    var id : NSNumber!
    var summary : String!
    var thumb : String!
    var title : String!
    var up : NSNumber!

}