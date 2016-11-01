//
//  IngreRecommendView.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/25.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

//定义食材首页Widget列表的类型
public enum IngreWidgetType: Int {
    case GuessYouLike = 1  //猜你喜欢
    case RedPacket = 2  //红包入口
    case TodayNew = 5  //今日新品
    case Scene = 3  //早餐日记等等
    case SceneList = 9  //全部场景
    case Talnet = 4  //推荐达人
    case Post = 8  //精选作品
    case Topic = 7   //专题
}


class IngreRecommendView: UIView {
    
    var jumpClosure: IngreJumpClosure?

    //数据
    var model: IngreRecommend? {
        didSet {
            //set方法调用之后会调用这里的方法
            tbView?.reloadData()
        }
    }
    
    //表格
    private var tbView: UITableView?
    
    //重新实现初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        //tbView?.backgroundColor = UIColor.blueColor()
        addSubview(tbView!)
        
        //约束
        tbView?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}



//MARK:UITableView代理
extension IngreRecommendView: UITableViewDelegate,  UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //banner广告部分显示一个分组
        var section = 1
        if model?.data?.widgetList?.count > 0{
            section += (model?.data?.widgetList?.count)!
        }
        return section
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //banner广告的section显示一行
        var row = 0
        if section == 0 {
            //广告
            row = 1
        }else{
            //获取list对象
            let listModel = model?.data?.widgetList![section-1]
            if (listModel?.widget_type?.integerValue)! == IngreWidgetType.GuessYouLike.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.RedPacket.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.TodayNew.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.Scene.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.SceneList.rawValue || (listModel?.widget_type?.integerValue)! == IngreWidgetType.Post.rawValue {
                //猜你喜欢/红包入口/今日新品/早餐日记等等/全部场景/精选作品
                row = 1
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Talnet.rawValue {
                //推荐达人
                row = (listModel?.widget_data?.count)! / 4
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue {
                //专题
                row = (listModel?.widget_data?.count)! / 3
            }

        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //banner广告高度为140
        var height: CGFloat = 0
        if indexPath.section == 0{
            //banner广告
            height = 140
        }else{
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.SceneList.rawValue {
                //猜你喜欢--GuessYouLike
                //全部场景--SceneList
                height = 70
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.RedPacket.rawValue {
                //红包入口
                height = 75
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                //今日新品
                height = 280
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Scene.rawValue {
                //早餐日记等等
                height = 200
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Talnet.rawValue {
                //推荐达人
                height = 80
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Post.rawValue {
                //精选作品
                height = 180
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue {
                //专题
                height = 120
            }
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            //banner广告
            let cell = IngreBannerCell.createBannerCellFor(tableView, atIndexPath: indexPath, bannerArray: model?.data!.bannerArray)
            //点击事件的响应代码
            cell.jumpClosure = jumpClosure
            return cell
        }else{
            //猜你喜欢
            let listModel = model?.data?.widgetList![indexPath.section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                
                let cell = IngreLikeCell.createLikeCellFor(tableView, atIndexPath: indexPath, listModel: listModel)
                
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.RedPacket.rawValue {
                
                let cell = IngreRedPacketCell.createRedPacketCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue {
                
                let cell = IngreTodayCell.createTodayCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Scene.rawValue {
                
                let cell = IngreSceneCell.createSceneCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.SceneList.rawValue {
                
                let cell = IngreSceneListCell.createSceneListCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                //点击事件
                cell.jumpClosure = jumpClosure
                
                cell.listModel = listModel
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Talnet.rawValue {
                //推荐达人
                
                //获取子数组
                /*
                 indexPath.row == 0  ----  0  1  2  3
                 indexPath.row == 1  ----  4  5  6  7
                 indexPath.row == 2  ----  8  9  10  11
                 */
                
                let range = NSMakeRange(indexPath.row*4, 4)
                let array = NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range) as! Array<IngreRecommendWidgetData>
                let cell = IngreTalnetCell.createTalnetCellFor(tableView, atIndexPath: indexPath, cellArray: array)
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Post.rawValue {
                
                let cell = IngrePostCell.createPostCellFor(tableView, atIndexPath: indexPath, listModel: listModel!)
                
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue {
                //专题
                
                //获取子数组
                /*
                 indexPath.row == 0  ----  0  1  2  3
                 indexPath.row == 1  ----  4  5  6  7
                 indexPath.row == 2  ----  8  9  10  11
                 */
                
                let range = NSMakeRange(indexPath.row*3, 3)
                let array = NSArray(array: (listModel?.widget_data)!).subarrayWithRange(range) as! Array<IngreRecommendWidgetData>
                let cell = IngreTopicCell.createTopicCellFor(tableView, atIndexPath: indexPath, cellArray: array)
                //点击事件
                cell.jumpClosure = jumpClosure
                
                return cell
            }
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section > 0 {
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢的分组的header
                let likeHeaderView = IngreLikeHeaderView(frame: CGRectMake(0, 0, (tbView?.bounds.size.width)!, 44))
                return likeHeaderView
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Scene.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Talnet.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Post.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue {
                //今日新品--TodayNew
                //早餐日记等等--Scene
                //推荐达人--Talnet
                //精选作品--Post
                //专题--Topic
                let headerView = IngreHeaderView(frame: CGRectMake(0,0,kScreenW,54))
                headerView.jumpClosure = jumpClosure
                headerView.listModel = listModel
                return headerView
            }
        }
        return nil
    }
    
    //设置header的高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        if section > 0 {
            let listModel = model?.data?.widgetList![section-1]
            if listModel?.widget_type?.integerValue == IngreWidgetType.GuessYouLike.rawValue {
                //猜你喜欢
                height = 44
            }else if listModel?.widget_type?.integerValue == IngreWidgetType.TodayNew.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Scene.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Talnet.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Post.rawValue || listModel?.widget_type?.integerValue == IngreWidgetType.Topic.rawValue{
                //今日新品--TodayNew
                //早餐日记等等--Scene
                //推荐达人--Talnet
                //精选作品--Post
                //专题--Topic
                height = 54
            }
        }
        return height
    }
    
    
    //去掉UITableView的粘滞性
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h: CGFloat = 54
        if scrollView.contentOffset.y >= h {
            scrollView.contentInset = UIEdgeInsets(top: -h, left: 0, bottom: 0, right: 0)
        }else if scrollView.contentOffset.y > 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
    
}