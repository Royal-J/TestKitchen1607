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
    
    //当前选择了第几集
    private var serialIndex: Int = 0
    
    
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
        
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 0, 0))
        })
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
                //刷新表格
                tbView?.reloadData()
                
                
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
        var num = 0
        
        if section == 0 {
            //详情
            if detailData != nil {
                num = 3
            }
        }else if section == 1 {
            //评论
            
        }
        return num
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {

        var h: CGFloat = 0
        if indexPath.row == 0 {
            //视频播放
            h = 160
        }else if indexPath.row == 1 {
            //文字
            let model = detailData?.data?.data![serialIndex]
            h = FCSubjectCell.heightForSubjectCell(model!)
        }else if indexPath.row == 2 {
            //集数
            h = FCSerialCell.heightForSerialCell((detailData?.data?.data?.count)!)
        }
        return h
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                //视频
                let cellId = "viedoCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCVideoCell
                if nil == cell {
                    cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
                }
                //显示数据
                let serialModel = detailData?.data?.data![serialIndex]
                cell?.cellModel = serialModel
                
                //播放的闭包
                cell?.playClosure = {[unowned self]
                    urlString in
                    IngreService.handleEvent(urlString, onViewController: self)
                }
                
                
                return cell!
            }else if indexPath.row == 1 {
                //文字
                let cellId = "subjectCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSubjectCell
                if nil == cell {
                    cell = NSBundle.mainBundle().loadNibNamed("FCSubjectCell", owner: nil, options: nil).last as? FCSubjectCell
                }
                //显示数据
                let model = detailData?.data?.data![serialIndex]
                cell?.cellModel = model
                cell?.selectionStyle = .None
                return cell!
            }else if indexPath.row == 2 {
                //集数
                let cellId = "serialCellId"
                var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
                if nil == cell {
                    cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
                }
                //显示数据
                cell?.serialNum = detailData?.data?.data?.count
                
                //设置选中的按钮
                cell?.selectIndex = serialIndex
                
                cell?.clickClosure = {[unowned self]
                    index in
                    self.serialIndex = index
                    //刷新表格
                    self.tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
                }
                
                cell?.selectionStyle = .None
                return cell!
            }
        }
        
        return UITableViewCell()
    }
    
    
}

