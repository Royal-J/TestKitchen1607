//
//  KTCDownloader.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/24.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

import Alamofire


protocol KTCDownloaderDelegate: NSObjectProtocol {
    //下载失败
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError)
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?)
}

enum KTCDownloadType: Int {
    case Normal = 0
    case IngreRecommend   //首页食材视图控制器的推荐视图
    case IngreMaterial    //首页食材视图控制器的食材视图
    case IngreCategory    //首页食材视图控制器的分类视图
}



class KTCDownloader: NSObject {
    
    //下载的类型
    var downloadType: KTCDownloadType = .Normal

    //代理属性（弱引用）
    weak var delegate: KTCDownloaderDelegate?
    
    //POST请求数据
    func postWituUrl(urlSting: String, params: Dictionary<String,AnyObject>) {
        //token=&user_id=&version=4.32
        var tmpDict = NSDictionary(dictionary: params) as! Dictionary<String,AnyObject>
        //设置所有接口的公共参数
        tmpDict["token"] = ""
        tmpDict["user_id"] = ""
        tmpDict["version"] = "4.5"
        
        Alamofire.request(.POST, urlSting, parameters: tmpDict, encoding: ParameterEncoding.URL, headers: nil).responseData {
           // [unowned self] 此处不能用，程序会崩溃，没有互相强引用
            (response) in
            switch response.result {
            case .Failure(let error):
                //出错了
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success:
                //下载成功
                self.delegate?.downloader(self, didFinishWithData: response.data)
            }
        }
    }
    
}
