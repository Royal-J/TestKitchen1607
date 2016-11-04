//
//  FoodCourseDetail.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/3.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit
import SwiftyJSON

class FoodCourseDetail: NSObject {
    
    var code: String?
    var data: FoodCourseDetailData?
    var msg: String?
    var timestamp: NSNumber?
    var version: String?
    
    class func parseData(data: NSData) -> FoodCourseDetail {
        let json = JSON(data: data)
        
        let model = FoodCourseDetail()
        model.code = json["code"].string
        
        model.data = FoodCourseDetailData.parse(json["data"])
        
        model.msg = json["msg"].string
        model.timestamp = json["timestamp"].number
        model.version = json["version"].string
        
        return model
    }
    
}


class FoodCourseDetailData: NSObject {
    /*
     "album" : "蓝猪坊",
     "album_logo" : "1478067938916_1376458904.jpg",
     "create_time" : "2016-10-09 15:03:35",
     "data" : []
     "episode" : 5,
     "last_update" : "2016-11-02 14:25:39",
     "order_no" : "1",
     "play" : 26348,
     "relate_activity" : "109",
     "series_id" : "121",
     "series_image" : "http://img.szzhangchu.com/1478067938583_7799533263.jpg",
     "series_name" : "#蓝猪坊#双色蔬菜水饺",
     "series_title" : "说到团圆，除了月饼以外还有一种食物也象征着团圆，那就是饺子！饺子是我国很古老的一种食物。尤其是在过年的时候，家家户户都在吃饺子，饺子也就自然被人们意为团圆的象征。    今天的这道饺子，以高颜值霸占饭桌好几载！趁着中秋假！给饭桌增添一抹赏心悦目的绿色！",
     "share_description" : null,
     "share_image" : null,
     "share_title" : null,
     "share_url" : "http://m.izhangchu.com/micro/shike.php?&material_id=121",
     "tag" : ""
     */
    var album: String?
    var album_logo: String?
    var create_time: String?
    var data: Array<FoodCourseSerial>?
    var episode: NSNumber?
    var last_update: String?
    var order_no: String?
    var play: NSNumber?
    var relate_activity: String?
    var series_id: String?
    var series_image: String?
    var series_name: String?
    var series_title: String?
    var share_description: String?
    var share_image: String?
    var share_title: String?
    var share_url: String?
    var tag: String?
    
    class func parse(json: JSON) -> FoodCourseDetailData {
        let model = FoodCourseDetailData()
        model.album = json["album"].string
        model.album_logo = json["album_logo"].string
        model.create_time = json["create_time"].string
        
        var array = Array<FoodCourseSerial>()
        for (_, subjson) in json["data"] {
            let serialModel = FoodCourseSerial.parse(subjson)
            array.append(serialModel)
        }
        model.data = array
        
        model.episode = json["episode"].number
        model.last_update = json["last_update"].string
        model.order_no = json["order_no"].string
        model.play = json["play"].number
        model.relate_activity = json["relate_activity"].string
        model.series_id = json["series_id"].string
        model.series_image = json["series_image"].string
        model.series_name = json["series_name"].string
        model.series_title = json["series_title"].string
        model.share_description = json["share_description"].string
        model.share_image = json["share_image"].string
        model.share_title = json["share_title"].string
        model.share_url = json["share_url"].string
        model.tag = json["tag"].string
        
        return model
    }
    
}


class FoodCourseSerial: NSObject {
    /*
     "course_id" : 1539,
     "course_image" : "http://img.szzhangchu.com/1475996698928_3739207663.jpg",
     "course_introduce" : "",
     "course_name" : "韭菜盒子",
     "course_subject" : "韭菜盒子表皮金黄酥脆，馅心韭香脆嫩，滋味优美，是适时佳点。",
     "course_video" : "http://video.szzhangchu.com/1475994552338_6022348552.mp4",
     "episode" : 1,
     "is_collect" : 0,
     "is_like" : 0,
     "ischarge" : "0",
     "price" : "0",
     "video_watchcount" : 5016
     */
    var course_id: NSNumber?
    var course_image: String?
    var course_introduce: String?
    var course_name: String?
    var course_subject: String?
    var course_video: String?
    var episode: NSNumber?
    var is_collect: NSNumber?
    var is_like: NSNumber?
    var ischarge: String?
    var price: String?
    var video_watchcount: NSNumber?
    
    class func parse(json: JSON) -> FoodCourseSerial {
        let model = FoodCourseSerial()
        model.course_id = json["course_id"].number
        model.course_image = json["course_image"].string
        model.course_introduce = json["course_introduce"].string
        model.course_name = json["course_name"].string
        model.course_subject = json["course_subject"].string
        model.course_video = json["course_video"].string
        model.episode = json["episode"].number
        model.is_collect = json["is_collect"].number
        model.is_like = json["is_like"].number
        model.ischarge = json["ischarge"].string
        model.price = json["price"].string
        model.video_watchcount = json["video_watchcount"].number
        
        return model
    }
    
}


