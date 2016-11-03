//
//  IngreService.swift
//  TestKitchen1607
//
//  Created by HJY on 2016/11/3.
//  Copyright © 2016年 HJY. All rights reserved.
//

import UIKit

class IngreService: NSObject {

    class func handleEvent(urlstring: String, onViewController vc: UIViewController) {
        
        if urlstring.hasPrefix("app://food_course_series") {
            //食材课程的分集显示
            
            let array = urlstring.componentsSeparatedByString("#")
            if array.count > 1 {
                let courseId = array[1]
                FoodCourseService.handleFoodCourse(courseId, onViewController: vc)
                
            }
            
        }
        
    }
    
    
}
