//
//  IngreMaterialCell.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/2.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreMaterialCell: UITableViewCell {

    //点击事件
    var jumpClosure: IngreJumpClosure?
    
    
    var cellModel: IngreMaterialType? {
        didSet {
            if cellModel != nil {
                
                //删除之前的子视图
                for sub in contentView.subviews {
                    sub.removeFromSuperview()
                }
                
                showData()
            }
        }
    }
    
    //标题高度
    class private var titleH: CGFloat {
        return 20
    }
    //间距
    class private var margin: CGFloat {
        return 10
    }
    //按钮的高度
    class private var btnH: CGFloat {
        return 44
    }
    //按钮的列数
    class private var colum: Int {
        return 5
    }
    //按钮的宽度
    class private var btnW: CGFloat {
        return (kScreenW-margin*CGFloat(colum+1))/CGFloat(colum)
    }
    
    func showData() {
        //类型标题
        let titleLabel = UILabel.createLabel(cellModel?.text, textAlignment: .Left, font: UIFont.systemFontOfSize(17))
        contentView.addSubview(titleLabel)
        
        //约束
        titleLabel.snp_makeConstraints { (make) in
            make.left.top.equalTo(IngreMaterialCell.margin)
            make.right.equalTo(-IngreMaterialCell.margin)
            make.height.equalTo(IngreMaterialCell.titleH)
        }
        
        //左上角图片
        let typeImageView = UIImageView()
        let url = NSURL(string: (cellModel?.image)!)
        typeImageView.kf_setImageWithURL(url!, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(typeImageView)
        
        //约束
        typeImageView.snp_makeConstraints { (make) in
            make.left.equalTo(IngreMaterialCell.margin)
            make.top.equalTo(IngreMaterialCell.margin*2+IngreMaterialCell.titleH)
            make.width.equalTo(IngreMaterialCell.btnW*2+IngreMaterialCell.margin)
            make.height.equalTo(IngreMaterialCell.btnH*2+IngreMaterialCell.margin)
        }
        
        //子类型按钮
        let cnt = cellModel?.data?.count
        if cnt > 0 {
            for i in 0..<cnt! {
                //显示文字
                let model = cellModel?.data![i]
                
                let btn = IngreMaterialBtn()
                btn.model = model
                
                //点击事件
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                
                contentView.addSubview(btn)
                
                if i < 6 {
                    //前面两行的按钮
                    let row = i/(IngreMaterialCell.colum-2) //行数
                    let col = i%(IngreMaterialCell.colum-2) //列数
                    btn.snp_makeConstraints(closure: { (make) in
                        let x = IngreMaterialCell.btnW*2+IngreMaterialCell.margin*3+(IngreMaterialCell.margin+IngreMaterialCell.btnW)*CGFloat(col)
                        make.left.equalTo(x)
                        let top = IngreMaterialCell.titleH+IngreMaterialCell.margin*2+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
                        make.top.equalTo(top)
                        make.width.equalTo(IngreMaterialCell.btnW)
                        make.height.equalTo(IngreMaterialCell.btnH)
                    })
                    
                }else{
                    
                    //后面几行的按钮
                    let row = (i-6)/IngreMaterialCell.colum //行数
                    let col = (i-6)%IngreMaterialCell.colum //列数
                    btn.snp_makeConstraints(closure: { (make) in
                        let x = IngreMaterialCell.margin+(IngreMaterialCell.margin+IngreMaterialCell.btnW)*CGFloat(col)
                        make.left.equalTo(x)
                        make.top.equalTo(typeImageView.snp_bottom).offset(IngreMaterialCell.margin+(IngreMaterialCell.margin+IngreMaterialCell.btnH)*CGFloat(row))
                        make.width.equalTo(IngreMaterialCell.btnW)
                        make.height.equalTo(IngreMaterialCell.btnH)
                    })
                    
                }
            }
        }
    }
    
    
    func clickBtn(btn: IngreMaterialBtn) {
        let tmpModel = btn.model
        if tmpModel?.id != nil && jumpClosure != nil {
            let urlString = "app://material#\((tmpModel?.id)!)#"
            jumpClosure!(urlString)
        }
    }
    
    
    //计算cell高度
    class func heightForCellWithModel(typeModel: IngreMaterialType) -> CGFloat {
     
        //子类型只有两行内时的高度
        var h = IngreMaterialCell.margin*2+IngreMaterialCell.titleH+(IngreMaterialCell.btnH+IngreMaterialCell.margin)*2
        
        //如果超过两行，加上这些高度
        if typeModel.data?.count > 6 {
            //超过的行数
            var row = ((typeModel.data?.count)!-6)/IngreMaterialCell.colum
            let tmpNum = ((typeModel.data?.count)!-6)%IngreMaterialCell.colum
            if tmpNum > 0 {
                //除不尽的需要再显示一行
                row += 1
            }
            h += (IngreMaterialCell.btnH+IngreMaterialCell.margin)*CGFloat(row)
        }
        return h
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

//按钮
class IngreMaterialBtn: UIControl {
    
    private var titleLabel: UILabel?
    
    //显示数据
    var model: IngreMaterialSubType? {
        didSet {
            //显示文字
            titleLabel?.text = model?.text
        }
    }
    
    init() {
        super.init(frame: CGRectZero)
        
        titleLabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(18))
        titleLabel!.numberOfLines = 0
        addSubview(titleLabel!)
        
        //约束
        titleLabel?.snp_makeConstraints(closure: { (make) in
            make.edges.equalToSuperview()
        })
        
        //背景颜色
        titleLabel?.backgroundColor = UIColor.init(white: 0.9, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}