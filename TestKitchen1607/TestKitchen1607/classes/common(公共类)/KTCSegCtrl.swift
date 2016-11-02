//
//  KTCSegCtrl.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/1.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

protocol KTCSegCtrlDelegate: NSObjectProtocol {
    //点击事件
    func segCtrl(segCtrl: KTCSegCtrl, didClickBtnAtIndex index: Int)
}



class KTCSegCtrl: UIView {
    
    //代理属性
    weak var delegate: KTCSegCtrlDelegate?
    
    //下划线图片
    private var lineView: UIImageView?
    
    //设置当前的序号
    var selectIndex: Int = 0 {
        didSet {
            //print(oldValue)
            
            if selectIndex != oldValue { //使当前界面不能再被点击，也可设置不能用户响应
                //取消之前的选中状态
                let lastBtn = viewWithTag(300+oldValue)
                if lastBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBtn = lastBtn as! KTCSegBtn
                    tmpBtn.clicked = false
                }
                //选中当前点击按钮
                let curBtn = viewWithTag(300+selectIndex)
                if curBtn?.isKindOfClass(KTCSegBtn) == true {
                    let tmpBtn = curBtn as! KTCSegBtn
                    tmpBtn.clicked = true
                }
                
                //修改下划线的位置
                UIView.animateWithDuration(0.25, animations: {
                    self.lineView?.frame.origin.x = (self.lineView?.frame.size.width)!*CGFloat(self.selectIndex)
                })
            }
            
        }
    }
    
    //重新实现初始化方法
    init(frame: CGRect, titleArray: Array<String>) {
        super.init(frame: frame)
        
        //创建按钮
        if titleArray.count > 0 {
            createBtns(titleArray)
        }
        
    }
    
    //创建按钮的方法
    func createBtns(titleArray: Array<String>) {
        //按钮宽度
        let w = bounds.size.width/CGFloat(titleArray.count)
        for i in 0..<titleArray.count {
            //循环创建按钮
            let frame = CGRectMake(w*CGFloat(i), 0, w, bounds.size.height)
            let btn = KTCSegBtn(frame: frame)
            
            //默认选中第一个
            if i == 0 {
                btn.clicked = true
            }else{
                btn.clicked = false
            }
            
            btn.config(titleArray[i])
            
            btn.tag = 300+i
            btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
            addSubview(btn)
        }
        
        //创建下划线图片
        lineView = UIImageView(frame: CGRectMake(0, bounds.size.height-66, w, 66))
        lineView?.image = UIImage(named: "navBtn_bag")
        //lineView?.backgroundColor = UIColor.redColor()
        addSubview(lineView!)
        
    }
    
    func clickBtn(btn: KTCSegBtn) {
        let index = btn.tag - 300
        
        //修改选中的UI
        selectIndex = index
        
        delegate?.segCtrl(self, didClickBtnAtIndex: index)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//自定制按钮
class KTCSegBtn: UIControl {
    
    private var titlelabel: UILabel?
    
    //设置选中状态
    var clicked: Bool = false {
        didSet {
            if clicked == true {
                //选中
                titlelabel?.textColor = UIColor.blackColor()
            }else{
                //取消选中
                titlelabel?.textColor = UIColor.lightGrayColor()
            }
        }
    }
    
    //显示数据
    func config(title: String?) {
        titlelabel?.text = title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titlelabel = UILabel.createLabel(nil, textAlignment: .Center, font: UIFont.systemFontOfSize(24))
        titlelabel?.frame = bounds
        addSubview(titlelabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
