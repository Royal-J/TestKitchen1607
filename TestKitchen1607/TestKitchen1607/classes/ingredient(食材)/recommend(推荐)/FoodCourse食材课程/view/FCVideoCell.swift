//
//  FCVideoCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/4.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {

    //播放视频
    var playClosure: (String -> Void)?
    
    
    //显示数据
    var cellModel: FoodCourseSerial? {
        didSet {
            if cellModel != nil {
                showData()
            }
        }
    }
    
    @IBOutlet weak var fcImageView: UIImageView!
    
    @IBOutlet weak var fcLabel: UILabel!
    
    @IBAction func btnClick(sender: UIButton) {
        if cellModel?.course_video != nil && playClosure != nil {
            playClosure!((cellModel?.course_video)!)
        }
        
        
    }
    
    func showData() {
        //图片
        let url = NSURL(string: (cellModel?.course_image)!)
        fcImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        //文字
        fcLabel.text = "\((cellModel?.video_watchcount)!)做过"
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
