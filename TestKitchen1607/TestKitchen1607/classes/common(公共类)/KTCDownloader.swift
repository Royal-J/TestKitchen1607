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

class KTCDownloader: NSObject {
   
    //代理属性（弱引用）
    weak var delegate: KTCDownloaderDelegate?
    
    //POST请求数据
    func postWituUrl(urlSting: String, params: Dictionary<String,AnyObject>) {
        Alamofire.request(.POST, urlSting, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData {
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
