//
//  HospitalModel.swift
//  LoveDog
//
//  Created by wei on 16/8/15.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import Foundation
import JSONModel

class HospitalModel: JSONModel {
//    
    var address : String!
    var avg_price : Int!
    var avg_rating : Float!
    var branch_name : String!
    var city : String!
    var comment_total : Int!
    var coupon_total : Int!
    var coupons : NSMutableArray?
    var distance : Int!
    var doctor_total : Int!
    var hours : String!
    var id : NSNumber!
    var latitude : NSNumber!
    var link : String!
    var longitude : NSNumber!
    var name : String!
    var photo_url : String!
    var region : String!
    var summary : String!
    var telephone : String!
//    
//    override class func propertyIsOptional(propertyName:String)->Bool{
//        return true
//    }
//    
//    override init() {
//        super.init()
//    }
////
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        super.init()
//        self.setValuesForKeysWithDictionary(dict as! [String:AnyObject])
//        let array = dict["coupons"] as? [AnyObject]
//        self.coupons = nil
//        self.coupons = NSMutableArray()
//        let couponsModel = CouponsModel.arrayOfModelsFromDictionaries(array)
//        self.coupons?.addObjectsFromArray(couponsModel as [AnyObject])
//    }
    //放在遇到未定义的属性时崩溃
//    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
//        
//    }
//    
//    required init(data: NSData!) throws {
//        fatalError("init(data:) has not been implemented")
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    required init(dictionary dict: [NSObject : AnyObject]!) throws {
//        fatalError("init(dictionary:) has not been implemented")
//    }


}

//class CouponsModel:JSONModel {
//    var id: Int!
//    var name: String!
//    var type: Int!
//}