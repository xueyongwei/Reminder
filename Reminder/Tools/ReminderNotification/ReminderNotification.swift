//
//  ReminderNotification.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/16.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

class ReminderNotification: NSObject {
    static let center = ReminderNotification()
    
    func registNotification(){
        let notiCenter = UNUserNotificationCenter.current()
        notiCenter.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            if granted {
                
            }else{
                EZAlertController.alert("您拒绝了通知权限", message: "这将导致您无法正常使用本应用的功能")
            }
        }
    }
    func handleLocalNoti(_ noti:UILocalNotification){
        if let userInfo = noti.userInfo{
            if let name = userInfo["name"] as? String,let note = userInfo["note"] as? String{
                UIAlertView.init(title: name, message: note, delegate: nil, cancelButtonTitle: "OK").show()
                
//                EZAlertController.alert(name, message: note)
            }
        }
    }
    func addNoti(with reminder:Reminder){
        let noti = UILocalNotification.init()
        noti.fireDate = reminder.fireDate
        noti.timeZone = NSTimeZone.default
//        noti.repeatInterval = NSCalendar.Unit.minute
        if let repeaType = RepeatModelViewController.RepeatType(rawValue: reminder.repeatType){
            noti.repeatInterval = self.repeatInterval(with: repeaType)
        }
        
        noti.alertTitle = reminder.name ?? "Reminder"
        noti.alertBody = reminder.note ?? "新的提醒"
        
        noti.userInfo = ["createDate":reminder.createDate!.description,"name":reminder.name ?? "Time Out","note":reminder.note ?? ""]
        
        noti.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(noti)
        
//        let content = UNMutableNotificationContent.init()
//        content.title = reminder.name ?? "Reminder"
//        content.body = reminder.note ?? "新的提醒"
//        content.sound = UNNotificationSound.default
//
//        let tiger = UNTimeIntervalNotificationTrigger.init(timeInterval: reminder.fireDate?.timeIntervalSince1970 ?? 0, repeats: true)
//
//        let notiRequest = UNNotificationRequest.init(identifier: "reminder", content: content, trigger: tiger)
//
//        UNUserNotificationCenter.current().add(notiRequest) { (error) in
//            print("推送成功")
//        }
    }
    func repeatInterval(with repeatModel:RepeatModelViewController.RepeatType) -> NSCalendar.Unit{
        switch repeatModel {
        case .once:
            return NSCalendar.Unit.init(rawValue: 0)
        case .hourly:
            return NSCalendar.Unit.hour
        case .daily:
            return NSCalendar.Unit.day
        case .weekly:
            return NSCalendar.Unit.weekOfYear
        case .monthly:
            return NSCalendar.Unit.month
        case .annum:
            return NSCalendar.Unit.year
        }
    }
    func remove(with remider:Reminder) {
        if let notis = UIApplication.shared.scheduledLocalNotifications{
            for noti in notis {
                if let createDate = noti.userInfo?["createDate"] as? String{
                    if remider.createDate!.description == createDate {
                        print("取消了通知\(String(describing: remider.name))")
                        UIApplication.shared.cancelLocalNotification(noti)
                    }
                }
            }
        }
        
    }
}
