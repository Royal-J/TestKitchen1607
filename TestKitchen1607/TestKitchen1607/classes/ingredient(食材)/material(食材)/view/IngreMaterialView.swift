//
//  IngreMaterialView.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/1.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreMaterialView: UIView {

    //表格
    private var tbView: UITableView?
    
    //显示数据
    var model: IngreMaterial? {
        didSet {
            if model != nil {
                tbView?.reloadData()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建表格
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
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
extension IngreMaterialView: UITableViewDelegate,UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if model?.data?.data?.count > 0 {
            row = (model?.data?.data?.count)!
        }
        return row
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellId = "IngreMaterialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? IngreMaterialCell
        if nil == cell {
            cell = IngreMaterialCell(style: .Default, reuseIdentifier: cellId)
        }
        //显示数据
        cell?.cellModel = model?.data?.data![indexPath.row]
        return cell!
    }
}
