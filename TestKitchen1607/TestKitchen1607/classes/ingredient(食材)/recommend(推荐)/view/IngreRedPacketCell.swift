//
//  IngreRedPacketCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/26.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit


public typealias IngreJumpClosure = (String -> Void)

class IngreRedPacketCell: UITableViewCell {
    
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    //容器子视图
    var containerView: UIView?
    
    @IBOutlet weak var scrollView: UIScrollView!

    //数据
    var listModel: IngreRecommendWidgetList? {
        didSet {
            showData()
        }
    }
    
    //显示数据
    func showData() {
        
        //删除之前的子视图
        if containerView != nil {
            containerView?.removeFromSuperview()
        }
        
        
        if listModel?.widget_data?.count > 0 {
            
            //容器视图
            containerView = UIView.createView()
            scrollView.addSubview(containerView!)
            
            containerView!.snp_makeConstraints(closure: { (make) in
                make.edges.equalToSuperview()
                make.height.equalToSuperview()
                })
            
            //上一次的视图
            var lastView: UIView? = nil
            
            let cnt = listModel?.widget_data?.count
            for i in 0..<cnt! {
                let data = listModel?.widget_data![i]
                
                if data?.type == "image" {
                    //创建图片
                    let url = NSURL(string: (data?.content)!)
                    let tmpimageView = UIImageView()
                    tmpimageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    containerView!.addSubview(tmpimageView)
                    
                    //点击事件
                    tmpimageView.userInteractionEnabled = true
                    tmpimageView.tag = 300+i
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                    tmpimageView.addGestureRecognizer(g)
                    
                    
                    
                    //约束
                    tmpimageView.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalToSuperview()
                        make.width.equalTo(210)
                        if i == 0 {
                            
                            //将滚动视图显示在最中间
                            let x = (CGFloat(210*cnt!)-scrollView.bounds.size.width)/2
                            
                            make.left.equalTo(containerView!).offset(-x)
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                    })
                    //设置上一张图片
                    lastView = tmpimageView
                }
                
            }
            
            //修改容器视图的宽度
            containerView!.snp_makeConstraints(closure: { (make) in
                make.right.equalTo(lastView!)
            })
            
            //设置代理
            scrollView.delegate = self
    
        }
    }
    
    func tapImage(g: UIGestureRecognizer) {
        let index = (g.view?.tag)! - 300
        let data = listModel?.widget_data![index]
        
        if jumpClosure != nil && data?.link != nil {
            jumpClosure!((data?.link)!)
        }
    }
    
    
    
    
    //创建cell的方法
    class func createRedPacketCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList) -> IngreRedPacketCell {
        
        let cellId = "ingreRedPacketCellId"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreRedPacketCell
        
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreRedPacketCell", owner: nil, options: nil).last as? IngreRedPacketCell
        }
        
        //数据
        cell?.listModel = listModel
        return cell!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


//MARK:UIScrollView代理
extension IngreRedPacketCell: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        let firstImageView = containerView!.viewWithTag(300)
        if firstImageView?.isKindOfClass(UIImageView) == true {
            firstImageView?.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(containerView!)
            })
        }
    }
}
