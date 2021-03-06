//
//  IngreSceneListCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/28.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreSceneListCell: UITableViewCell {
    
    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    //数据
    var listModel: IngreRecommendWidgetList? {
        didSet {
            config(listModel?.title)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private func config(text: String?) {
        titleLabel.text = text
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //点击手势
        let g = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        addGestureRecognizer(g)
        
    }
    
    func tapAction() {
        if jumpClosure != nil && listModel?.title_link != nil {
            jumpClosure!((listModel?.title_link)!)
        }
    }
    
    class func createSceneListCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, listModel: IngreRecommendWidgetList?) -> IngreSceneListCell {
        let cellId = "ingreSceneListCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreSceneListCell
        if nil == cell {
            cell = NSBundle.mainBundle().loadNibNamed("IngreSceneListCell", owner: nil, options: nil).last as? IngreSceneListCell
        }
        cell?.listModel = listModel
        return cell!
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
