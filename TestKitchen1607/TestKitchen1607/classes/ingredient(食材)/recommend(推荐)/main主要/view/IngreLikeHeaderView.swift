//
//  IngreLikeHeaderView.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/10/26.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreLikeHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //设置背景颜色
        backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        //文本输入框
        let textField = UITextField(frame: CGRectMake(40, 8, bounds.size.width-40*2, 28))
        textField.placeholder = "请输入菜名或食材搜索"
        textField.borderStyle = .RoundedRect
        addSubview(textField)
        
        //设置左边的搜索图片
        let image = UIImage(named: "search1")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.leftView = imageView
        textField.leftViewMode = .Always
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
