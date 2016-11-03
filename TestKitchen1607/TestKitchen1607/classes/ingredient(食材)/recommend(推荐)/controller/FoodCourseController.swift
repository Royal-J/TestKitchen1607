//
//  FoodCourseController.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/3.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class FoodCourseController: BaseViewController {

    var courseId: String?
    
    //详情的数据
    private var detailData: FoodCourseDetail?
    
    //表格
    var tbView: UITableView?
    
    //创建表格
    func createTableView() {
        automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        view.addSubview(tbView!)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        downloadDetailData()
        
    }
    
    //下载详情的数据
    func downloadDetailData() {
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.32
        let params = ["methodName":"CourseSeriesView","series_id":"\(courseId!)"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.downloadType = .IngreFoodCourseDetail
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
extension FoodCourseController: KTCDownloaderDelegate {
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.downloadType == .IngreFoodCourseDetail {
            //详情
            //            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            print(str!)
            
            if let tmpData = data {
                detailData = FoodCourseDetail.parseData(tmpData)
                //显示数据
                
                
            }
            
        }else if downloader.downloadType == .IngreFoodCourseComment {
            
        }
        
    }
}

//MARK:UITableView代理
extension FoodCourseController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            //详情
            return 3
        }else if section == 1 {
            //评论
            return 0
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        
        
        return UITableViewCell()
    }
    
    
}

