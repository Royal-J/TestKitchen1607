//
//  IngreRecommend.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/24.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

import SwiftyJSON

class IngreRecommend: NSObject {
    var code: NSNumber?
    var data: IngreRecommendData?
    var msg: NSNumber?
    var timestamp: String?
    var version: String?
    
    //解析
    class func parseData(data: NSData) -> IngreRecommend {
        
        let json = JSON(data: data)
        let model = IngreRecommend()
        model.code = json["code"].number
        model.data = IngreRecommendData.parseModel(json["data"])
        model.msg = json["msg"].number
        model.timestamp = json["timestamp"].string
        model.version = json["version"].string
        
        return model
    }
}




class IngreRecommendData: NSObject {
    var bannerArray: Array<IngreRecommendBanner>?
    var widgetList: Array<NSObject>?
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommendData {
        
        let model = IngreRecommendData()
        //广告数据
        var tmpBannerArray = Array<IngreRecommendBanner>()
        for (index, subjson) in json["banner"] {
            let bannerModel = IngreRecommendBanner.parseModel(subjson)
            tmpBannerArray.append(bannerModel)
        }
        model.bannerArray = tmpBannerArray
        
        //列表数据
        var tmpList = Array<NSObject>()
        for (index, subjson) in json["widgetList"] {
            let wModel = NSObject()
            tmpList.append(wModel)
        }
        model.widgetList = tmpList
        
        return model
    }
}



class IngreRecommendBanner: NSObject {
    var banner_id: NSNumber?
    var banner_title:String?
    var banner_picture:String?
    var banner_link:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    var type_id: NSNumber?
    
    //解析
    class func parseModel(json: JSON) -> IngreRecommendBanner {
        let model = IngreRecommendBanner()
        model.banner_id = json["banner_id"].number
        model.banner_title = json["banner_title"].string
        model.banner_picture = json["banner_picture"].string
        model.banner_link = json["banner_link"].string
        model.is_link = json["is_link"].number
        model.refer_key = json["refer_key"].number
        model.type_id = json["type_id"].number
        
        return model
    }
    
    
}
