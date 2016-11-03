//
//  FoodCourseService.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/3.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class FoodCourseService: NSObject {
    
    class func handleFoodCourse(courseId: String, onViewController vc: UIViewController) {
        
        //跳转到食材课程分页的界面
        let ctrl = FoodCourseController()
        ctrl.courseId = courseId
        
        vc.navigationController?.pushViewController(ctrl, animated: true)
    }
    
    
}
