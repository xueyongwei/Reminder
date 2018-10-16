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
    
    func addNoti(with reminder:Reminder){
        let noti = UILocalNotification.init()
        noti.fireDate = reminder.fireDate
        noti.timeZone = NSTimeZone.default
        noti.repeatInterval = NSCalendar.Unit.minute
        noti.alertTitle = reminder.name ?? "Reminder"
        noti.alertBody = reminder.note ?? "新的提醒"
        noti.userInfo = ["reminderID":reminder.objectID]
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
    
    func remove(with remider:Reminder) {
        if let notis = UIApplication.shared.scheduledLocalNotifications{
            for noti in notis {
                if let objectID = noti.userInfo?["reminderID"] as? NSManagedObjectID{
                    if objectID == remider.objectID {
                        print("取消了通知\(remider.name)")
                        UIApplication.shared.cancelLocalNotification(noti)
                    }
                }
            }
        }
        
    }
}
