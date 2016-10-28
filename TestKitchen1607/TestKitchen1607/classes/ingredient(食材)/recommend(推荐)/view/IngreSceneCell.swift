//
//  IngreSceneCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/28.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreSceneCell: UITableViewCell {

    //点击事件
    var jumpClosure: IngreJumpClosure?

    //数据
    var listModel: IngreRecommendWidgetList? {
        didSet {
            //显示数据
            showData()
        }
    }
    
    
    func showData() {
        //1.左边按钮
        //图片
        if listModel?.widget_data?.count > 0 {
            let sceneData = listModel?.widget_data![0]
            let url = NSURL(string: (sceneData?.content)!)
            
            sceneBtn.kf_setBackgroundImageWithURL(url, forState: .Normal)
        }
        
        //标题
        if listModel?.widget_data?.count > 1 {
            let titleData = listModel?.widget_data![1]
            sceneNameLabel.text = titleData?.content
        }
        
        //数量
        if listModel?.widget_data?.count > 2 {
            let numData = listModel?.widget_data![2]
            sceneNumLabel.text = numData?.content
        }
        
        //2.右边按钮
        for i in 0..<4 {
            //图片
            //i:    0  1  2  3
            //image:3  5  7  9 ---i*2+3
            
            if listModel?.widget_data?.count > i*2+3 {
                let btnData = listModel?.widget_data![i*2+3]
                if btnData?.type == "image" {
                    let tmpView = contentView.viewWithTag(100+i)
                    if tmpView?.isKindOfClass(UIButton) == true {
                        let btn = tmpView as! UIButton
                        let url = NSURL(string: (btnData?.content)!)
                        btn.kf_setBackgroundImageWithURL(url!, forState: .Normal)
                    }
                }
            }
            
            //视频
        }
        
        //3.下边Label
        descLabel.text = listModel?.desc
    }
    
    
    
    @IBOutlet weak var sceneBtn: UIButton!
    
    @IBOutlet weak var sceneNameLabel: UILabel!
    
    @IBOutlet weak var sceneNumLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBAction func clickSceneBtn() {
        //左边按钮点击事件
        if listModel?.widget_data?.count > 0 {
            let sceneData = listModel?.widget_data![0]
            if sceneData?.link != nil && jumpClosure != nil {
                jumpClosure!((sceneData?.link)!)
            }
        }
        
    }
    
    @IBAction func clickImageBtn(sender: UIButton) {
        //右边按钮图片的点击事件
        let index = sender.tag-100
        //数据对象的序号--->index*2+3
        if listModel?.widget_data?.count > index*2+3 {
            let data = listModel?.widget_data![index*2+3]
            if data?.link != nil && jumpClosure != nil {
                jumpClosure!((data?.link)!)
            }
            
        }
        
    }
    
    @IBAction func playAction(sender: UIButton) {
        //左边播放视频按钮的点击事件
        let index = sender.tag-200
        if listModel?.widget_data?.count > index*2+4 {
            let videoData = listModel?.widget_data![index*2+4]
            if videoData?.content != nil && jumpClosure != nil {
                jumpClosure!((videoData?.content)!)
            }
        }
        
    }
    
    
    //创建cell的方法
    class func createSceneCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList?) -> IngreSceneCell {
        let cellId = "ingreSceneCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreSceneCell", owner: nil, options: nil).last as? IngreSceneCell
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
