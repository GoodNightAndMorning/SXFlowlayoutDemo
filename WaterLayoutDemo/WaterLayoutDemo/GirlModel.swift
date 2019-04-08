//
//  GirlModel.swift
//  WaterLayoutDemo
//
//  Created by zsx on 2019/2/21.
//  Copyright © 2019年 zsx. All rights reserved.
//

import UIKit

class GirlModel: NSObject {
    var girlName:String = ""
//    var width:CGFloat = 0
    var height:CGFloat = 200
    var isLoad:Bool = false
    var index:Int = 0
    
    func setHeight(h:CGFloat) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            [unowned self] in
            
            self.height = h
            self.isLoad = true
        }
    }
}
