//
//  IngredientViewController.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngredientViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        //滚动视图或者其子视图放在导航下面，会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        downloadRecommendData()
    }
    
    //下载首页的推荐数据
    func downloadRecommendData() {
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWituUrl(kHostUrl, params: params)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}

//MARK:KTCDownloader代理
extension IngredientViewController:KTCDownloaderDelegate {
    //下载shib
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    //下载成功
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
//        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print(str)
        if let tmpData = data {
            //1.json解析
            let recommendModel = IngreRecommend.parseData(tmpData)
            
            
            //2.显示UI
            let recommendView = IngreRecommendView(frame: CGRectZero)
            recommendView.model = recommendModel
            view.addSubview(recommendView)
            
            //约束
            recommendView.snp_makeConstraints(closure: { (make) in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            })
            
            
        }
    }
}
