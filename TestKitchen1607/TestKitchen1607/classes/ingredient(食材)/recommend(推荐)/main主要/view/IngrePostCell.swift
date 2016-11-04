//
//  IngrePostCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/31.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngrePostCell: UITableViewCell {

    //点击外层按钮跳转
    @IBAction func clickBtn(sender: UIButton) {
        let index = sender.tag - 100
        if listModel?.widget_data?.count > 3*index {
            let imageData = listModel?.widget_data![3*index]
            if imageData?.link != nil && jumpClosure != nil {
                jumpClosure!((imageData?.link)!)
            }
        }
        
        
    }
    
    //点击用户头像跳转
    @IBAction func clickUserBtn(sender: UIButton) {
        let index = sender.tag - 300
        if listModel?.widget_data?.count > 3*index+1 {
            let userData = listModel?.widget_data![3*index+1]
            if userData?.link != nil && jumpClosure != nil {
                jumpClosure!((userData?.link)!)
            }
        }

        
        
    }
    
    @IBOutlet weak var descLabel: UILabel!
    
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    //显示数据
    var listModel: IngreRecommendWidgetList? {
        didSet {
            showData()
        }
    }
    
    
    func showData() {
        if listModel?.widget_data?.count > 0 {
            for i in 0..<3 {
                //i: 0  1  2
                //图片
                //0  3  6
                if listModel?.widget_data?.count > 3*i {
                    let imageData = listModel?.widget_data![3*i]
                    if imageData?.type == "image" {
                        let tmpView = contentView.viewWithTag(200+i)
                        if tmpView?.isKindOfClass(UIImageView) == true {
                            let imageView = tmpView as! UIImageView
                            let url = NSURL(string: (imageData?.content)!)
                            imageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                        }
                    }
                }
                
                //用户头像
                //1  4  7
                if listModel?.widget_data?.count > 3*i+1 {
                    let userImagedata = listModel?.widget_data![3*i+1]
                    if userImagedata?.type == "image" {
                        let tmpView = contentView.viewWithTag(300+i)
                        if tmpView?.isKindOfClass(UIButton) == true {
                            let userBtn = tmpView as! UIButton
                            let url = NSURL(string: (userImagedata?.content)!)
                            userBtn.kf_setBackgroundImageWithURL(url!, forState: .Normal)
                            userBtn.layer.cornerRadius = 15
                            userBtn.layer.masksToBounds = true
                        }
                    }
                }
                
                //用户名字
                //2  5  8
                if listModel?.widget_data?.count > 3*i+2 {
                    let textData = listModel?.widget_data![3*i+2]
                    if textData?.type == "text" {
                        let tmpView = contentView.viewWithTag(400+i)
                        if tmpView?.isKindOfClass(UILabel) == true {
                            let label = tmpView as! UILabel
                            label.text = textData?.content
                        }
                    }
                }
            }
            
            //描述文字
            descLabel.text = listModel?.desc
        }
    }
    
    //创建cell的方法
    class func createPostCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList) -> IngrePostCell {
        let cellId = "ingrePostCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngrePostCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngrePostCell", owner: nil, options: nil).last as? IngrePostCell
        }
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
