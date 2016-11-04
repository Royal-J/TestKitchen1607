//
//  IngredientViewController.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/21.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngredientViewController: KTCTabViewController {
    
    //滚动视图
    private var scrollView: UIScrollView?
    //推荐视图
    private var recommendView: IngreRecommendView?
    //食材视图
    private var materialView: IngreMaterialView?
    //分类视图
    private var categoryView: IngreMaterialView?
    
    //导航上面的额选择控件
    private var segCtrl: KTCSegCtrl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.redColor()
        //滚动视图或者其子视图放在导航下面，会自动加一个上面的间距，我们要取消这个间距
        automaticallyAdjustsScrollViewInsets = false
        
        //导航
        createNav()
        
        //创建首页视图
        createHomePage()
        
        //下载首页的推荐数据
        downloadRecommendData()
        
        //下载首页的食材数据
        downloadRecommendMaterial()
        
        //下载首页的分类数据
        downloadCategoryData()
    }
    
    //创建首页视图
    func createHomePage() {
        scrollView = UIScrollView()
        scrollView!.pagingEnabled = true
        scrollView?.delegate = self
        view.addSubview(scrollView!)
        
        //约束
        scrollView!.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        
        //容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        //添加子视图
        //1.推荐视图
        recommendView = IngreRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.left.equalToSuperview()
            make.width.equalTo(kScreenW)
        })
        //2.食材视图
        materialView = IngreMaterialView()
        //materialView?.backgroundColor = UIColor.blueColor()
        containerView.addSubview(materialView!)
        materialView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenW)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        //3.分类视图
        categoryView = IngreMaterialView()
        //categoryView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(kScreenW)
            make.left.equalTo((materialView?.snp_right)!)
        })
        
        //修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo(categoryView!)
        }
        
    }
    
    
    
    func createNav() {
        //左边扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        //右边🔍
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
        
        //选择控件
        let frame = CGRectMake(80, 0, kScreenW-80*2, 44)
        segCtrl = KTCSegCtrl(frame: frame, titleArray: ["推荐","食材","分类"])
        segCtrl!.delegate = self
        navigationItem.titleView = segCtrl
        
    }
    
    //扫一扫
    func scanAction() {
        print("扫一扫")
    }
    
    //搜索
    func searchAction() {
        print("搜索")
    }
    
    
    //下载首页的推荐数据
    func downloadRecommendData() {
        //methodName=SceneHome&token=&user_id=&version=4.5
        let params = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.downloadType = .IngreRecommend
        downloader.postWituUrl(kHostUrl, params: params)
    }
    
    //下载首页的食材数据
    func downloadRecommendMaterial() {
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.downloadType = .IngreMaterial
        downloader.postWituUrl(kHostUrl, params: dict)
    }
    
    //下载首页的分类数据
    func downloadCategoryData() {
        let dict = ["methodName":"CategoryIndex"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.downloadType = .IngreCategory
        downloader.postWituUrl(kHostUrl, params: dict)
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
        if downloader.downloadType == .IngreRecommend {
            if let tmpData = data {
                //1.json解析
                let recommendModel = IngreRecommend.parseData(tmpData)
                
                
                //2.显示UI
                recommendView!.model = recommendModel
                
                //3.点击食材的推荐页面的某一部分，跳转到后面的界面
                recommendView!.jumpClosure = {[unowned self] (jumpUrl) in
                   self.handleClickEvent(jumpUrl)
                }
            }
        }else if downloader.downloadType == .IngreMaterial {
            if let tmpData = data {
                let model = IngreMaterial.parseData(tmpData)
                
                materialView?.model = model
                
                //点击事件
                materialView?.jumpClosure = {[unowned self] (jumpUrl) in
                    self.handleClickEvent(jumpUrl)
                }
                
            }
            
        }else if downloader.downloadType == .IngreCategory {
            if let tmpData = data {
                let model = IngreMaterial.parseData(tmpData)
                
                categoryView?.model = model
                
                //点击事件
                categoryView?.jumpClosure = {[unowned self] (jumpUrl) in
                    self.handleClickEvent(jumpUrl)
                }
            }

        }
    }
    
    
    //处理点击事件的方法
    func handleClickEvent(urlString: String) {
        //print(urlString)
        IngreService.handleEvent(urlString, onViewController: self)
    }
    
    
    
    
}


//MARK:KTCSegCtrl代理
extension IngredientViewController: KTCSegCtrlDelegate {
    func segCtrl(segCtrl: KTCSegCtrl, didClickBtnAtIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(CGFloat(index)*kScreenW, 0), animated: true)
    }
}


//MARK:UIScrollViewd的代理
extension IngredientViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x/scrollView.bounds.size.width
        segCtrl?.selectIndex = Int(index)
    }
}
