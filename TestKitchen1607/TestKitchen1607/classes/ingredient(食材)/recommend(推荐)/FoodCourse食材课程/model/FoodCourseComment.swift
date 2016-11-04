//
//  FoodCourseComment.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/4.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseComment: NSObject {
    
    var code: String?
    var data: FoodCourseCommentData?
    var msg: String?
    var timestamp: NSNumber?
    var version: String?
    
    class func parseData(data: NSData) -> FoodCourseComment {
        let json = JSON(data: data)
        
        let model = FoodCourseComment()
        model.code = json["code"].string
        
        model.data = FoodCourseCommentData.parse(json["data"])
        
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }

}


class FoodCourseCommentData: NSObject {
    var count: String?
    var data: Array<FoodCourseCommentDetail>?
    var page: String?
    var size: String?
    var total: String?
    
    class func parse(json: JSON) -> FoodCourseCommentData {
        
        let model = FoodCourseCommentData()
        model.count = json["count"].string
        
        var array = Array<FoodCourseCommentDetail>()
        for (_,subjson) in json["data"] {
            let detail = FoodCourseCommentDetail.parse(subjson)
            array.append(detail)
        }
        model.data = array

        model.page = json["page"].string
        model.size = json["size"].string
        model.total = json["total"].string
        
        return model
    }
}


class FoodCourseCommentDetail: NSObject {
    /*
 "content" : "我觉得嫩豆腐比北豆腐更适合一些",
 "create_time" : "10月22日",
 "head_img" : "http://q.qlogo.cn/qqapp/100956582/A4C8D71FA25B90742D10725FEC112CB4/100",
 "id" : "88317",
 "istalent" : 0,
 "nick" : "野渡无人有面就好",
 "parent_id" : "0",
 "parents" : [],
 "relate_id" : "118",
 "type" : "2",
 "user_id" : "1736506"
     */
    
    var content: String?
    var create_time: String?
    var head_img: String?
    var id: String?
    var istalent: NSNumber?
    var nick: String?
    var parent_id: String?
    var parents: Array<FoodCourseCommentDetail>?
    var relate_id: String?
    var type: String?
    var user_id: String?
    
    class func parse(json: JSON) -> FoodCourseCommentDetail {
        let model = FoodCourseCommentDetail()
        model.content = json["content"].string
        model.create_time = json["create_time"].string
        model.head_img = json["head_img"].string
        model.id = json["id"].string
        model.istalent = json[""].number
        model.nick = json["nick"].string
        model.parent_id = json["parent_id"].string
        
        var array = Array<FoodCourseCommentDetail>()
        for (_,subjson) in json["parents"] {
            let pModel = FoodCourseCommentDetail.parse(subjson)
            array.append(pModel)
        }
        model.parents = array
        
        model.relate_id = json["relate_id"].string
        model.type = json["type"].string
        model.user_id = json["user_id"].string
        
        return model
    }
    
}