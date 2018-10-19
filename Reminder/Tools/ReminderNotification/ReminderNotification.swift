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
    
    func upcomingNoti() -> UILocalNotification?{
        if let notis = UIApplication.shared.scheduledLocalNotifications,notis.count > 0{
            var coming = notis.first!
            
            for noti in notis{
                if coming.nextComingInterval() < noti.nextComingInterval(){
                    coming = noti
                }
//                let comingInterval = self.getNextComeTimeInterval(coming)
//                if comingInterval > 0 {
//                    let notiInterval = self.getNextComeTimeInterval(noti)
//                    if notiInterval < comingInterval{
//                        coming = noti
//                    }
//                }
//                if let comingDate = coming?.fireDate,let date = noti.fireDate {
//                    if comingDate > date{
//
//                        coming = noti
//                    }
//                }
            }
            return coming
        }
        return nil
    }
    
    func getNextComeTimeInterval(_ anoti:UILocalNotification? )->Int{
        guard let noti = anoti else {
            return -1
        }
        if let fireDate = noti.fireDate {
            
            let now = Date.init()
            let calendar = Calendar.current
            let components:Set<Calendar.Component> = [.year,.month,.weekOfYear,.day,.hour]
            let nowDateComponent = calendar.dateComponents(components, from: now)
            let fireDateComponent = calendar.dateComponents(components, from: fireDate)
            guard let fireMo = fireDateComponent.month,let fireW = fireDateComponent.weekOfYear,let fireD = fireDateComponent.day,let fireH = fireDateComponent.hour,let fireMn = fireDateComponent.minute,let fireS = fireDateComponent.second else {
                return -1
            }
            guard let nowMo = nowDateComponent.month,let nowW = nowDateComponent.weekOfYear,let nowD = nowDateComponent.day,let nowH = nowDateComponent.hour,let nowMn = nowDateComponent.minute,let nowS = nowDateComponent.second else {
                return -1
            }
            switch noti.repeatInterval  {
            case .hour:
                if fireMn > nowMn{
                    let sec = (fireMn - nowMn) * 60
                    return sec + (fireS - nowS)
                }else{
                    let sec = (nowMn - fireMn + 60) * 60
                    return sec + (fireS - nowS)
                }
            case .day:
                if fireH > nowH{
                    let m = (fireH - nowH) * 60
                    return m*60 + (fireMn - nowMn)*60 + (fireS - nowS)
                }else{
                    let m = (fireH - nowH + 24) * 60
                    return m*60 + (fireMn - nowMn)*60 + (fireS - nowS)
                }
            case .weekOfYear:
                if fireW > nowW{
                    let h = (fireW - nowW)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }else{
                    let h = (fireW - nowW + 7)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }
            case .month:
                if fireD > nowD{
                    let h = (fireD - nowD)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }else{
                    let h = (fireD - nowD + 30)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }
            case .year:
                if fireMo > nowMo{
                    let d = (fireMo - nowMo)*30
                    return (((d + fireD - nowD)*24 + fireH - nowH)*60 + fireMn - nowMn )*60 + fireS - nowS
                }else{
                    let d = (fireMo - nowMo + 12)*30
                    return (((d + fireD - nowD)*24 + fireH - nowH)*60 + fireMn - nowMn )*60 + fireS - nowS
                }
            default:
                break
            }
        }
        return -1
    }
    
    func addNoti(with reminder:Reminder){
        let noti = UILocalNotification.init()
        noti.fireDate = reminder.fireDate
//        noti.timeZone = NSTimeZone.default
//        noti.repeatInterval = NSCalendar.Unit.minute
        if let repeaType = RepeatModelViewController.RepeatType(rawValue: reminder.repeatType){
            if repeaType != .once{
                noti.repeatInterval = self.repeatInterval(with: repeaType)
            }
            
        }
        
        noti.alertTitle = reminder.name ?? "Reminder"
        noti.alertBody = reminder.note ?? "新的提醒"
        
        noti.userInfo = ["createDate":reminder.createDate!,"name":reminder.name ?? "Time Out","note":reminder.note ?? "","fireDate":reminder.fireDate!]
        
        noti.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(noti)
        print("添加了通知 \(noti)")
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
            print("共有通知\n\(notis)\n")
            for noti in notis {
                
                if let createDate = noti.userInfo?["createDate"] as? Date{
                    
                    if remider.createDate! == createDate {
                        print("取消了通知\(noti)")
                        
                        UIApplication.shared.cancelLocalNotification(noti)
                    }
                }
            }
        }
        
    }
}

extension UILocalNotification{
    func nextComingInterval() -> Int {
        if let fireDate = self.fireDate {
            
            let now = Date.init()
            let calendar = Calendar.current
            let components:Set<Calendar.Component> = [.year,.month,.weekOfYear,.day,.hour,.hour,.minute,.second]
            let nowDateComponent = calendar.dateComponents(components, from: now)
            let fireDateComponent = calendar.dateComponents(components, from: fireDate)
            guard let fireMo = fireDateComponent.month,let fireW = fireDateComponent.weekOfYear,let fireD = fireDateComponent.day,let fireH = fireDateComponent.hour,let fireMn = fireDateComponent.minute,let fireS = fireDateComponent.second else {
                return 1
            }
            guard let nowMo = nowDateComponent.month,let nowW = nowDateComponent.weekOfYear,let nowD = nowDateComponent.day,let nowH = nowDateComponent.hour,let nowMn = nowDateComponent.minute,let nowS = nowDateComponent.second else {
                return 1
            }
            switch self.repeatInterval  {
            case .hour:
                if fireMn > nowMn{
                    let sec = (fireMn - nowMn) * 60
                    return sec + (fireS - nowS)
                }else{
                    let sec = (nowMn - fireMn + 60) * 60
                    return sec + (fireS - nowS)
                }
            case .day:
                if fireH > nowH{
                    let m = (fireH - nowH) * 60
                    return m*60 + (fireMn - nowMn)*60 + (fireS - nowS)
                }else{
                    let m = (fireH - nowH + 24) * 60
                    return m*60 + (fireMn - nowMn)*60 + (fireS - nowS)
                }
            case .weekOfYear:
                if fireW > nowW{
                    let h = (fireW - nowW)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }else{
                    let h = (fireW - nowW + 7)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }
            case .month:
                if fireD > nowD{
                    let h = (fireD - nowD)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }else{
                    let h = (fireD - nowD + 30)*24
                    return ((h + fireH - nowH)*60 + fireMn - nowMn)*60 + fireS - nowS
                }
            case .year:
                if fireMo > nowMo{
                    let d = (fireMo - nowMo)*30
                    return (((d + fireD - nowD)*24 + fireH - nowH)*60 + fireMn - nowMn )*60 + fireS - nowS
                }else{
                    let d = (fireMo - nowMo + 12)*30
                    return (((d + fireD - nowD)*24 + fireH - nowH)*60 + fireMn - nowMn )*60 + fireS - nowS
                }
            default:
                if fireDate > now {
                    return Int(fireDate.timeIntervalSince(now))
                }
                break
            }
        }
        return 1
    }
}


