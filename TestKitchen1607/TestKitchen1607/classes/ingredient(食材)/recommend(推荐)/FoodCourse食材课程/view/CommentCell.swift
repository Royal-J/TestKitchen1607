//
//  CommentCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/4.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //显示数据
    var model: FoodCourseCommentDetail? {
        didSet {
            if model != nil {
                //图片
                let url = NSURL(string: (model?.head_img)!)
                userImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                //名字
                usernameLabel.text = model?.nick
                //评论
                descLabel.text = model?.content
                //时间
                timeLabel.text = model?.create_time
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        userImageView.layer.cornerRadius = 30
        userImageView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
