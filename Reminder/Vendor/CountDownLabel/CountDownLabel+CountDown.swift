//
//  CountDownLabel+CountDown.swift
//  CountDownLabel
//
//  Created by Charlin on 16/5/30.
//  Copyright © 2016年 Charlin. All rights reserved.
//

import UIKit

extension CountDownLabel {
    


    /** 开始计时 */
    func start(){
        
        if timer != nil {return}
        
        timer = timerPrepare()
        
        maxSecond_private = maxSecond
        
        updateTimeCount()
    }
    
    /** 停止计时 */
    func stop(){
        
        timerValidate()
    }
    
    func updateTimeCount(){
    
        let hour = maxSecond_private/3600
        let min = (maxSecond_private%3600)/60
        let sec = maxSecond_private%60
        var showText = prefix
        
        if hour > 0 {
            let hourText = String(format: "%02d:", hour)
            showText += hourText
        }
        let minText = String(format: "%02d", min)
        let secText = String(format: "%02d", sec)
        
        text = showText + minText + ":" + secText
//
//        //格式化时间
//        let min = maxSecond_private / 60
//        let min_Str = String(format: "%02d", min)
//
//
//        let sec = maxSecond_private - min * 60
//        let sec_Str = String(format: "%02d", sec)
//
//        text = prefix + min_Str + ":" + sec_Str
    }
}
