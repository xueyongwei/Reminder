//
//  Persistent.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/12.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
import CoreData
class Persistent: NSObject {

    static let store = Persistent()
    
    fileprivate var cdManager = CDManager.shared
}

extension Persistent {
    
    func addNewReminder(name:String, note:String = "", fireDate:Date,
                        repeatType:Int16, shouldNoti:Bool ,shouldCalendar:Bool = false) -> Bool{
        let areminder = NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: CDManager.shared.context) as! Reminder
        areminder.name = name
        areminder.note = note
        areminder.fireDate = fireDate
        areminder.notify = shouldNoti
        areminder.repeatType = repeatType
        areminder.calendar = shouldCalendar
        areminder.createDate = Date.init(timeIntervalSinceNow: 0)
        do {
            try self.cdManager.context.save()
            NotificationCenter.default.post(name: NSNotification.Name.EX.coreDataChanged, object: nil, userInfo: nil)
        } catch  {
            EZAlertController.alert("数据库存储失败", message: error.localizedDescription)
            return false
        }
        return true
    }
    
    func deleteReminder(_ reminder:Reminder) -> Bool{
        self.cdManager.context.delete(reminder)
        do {
            try self.cdManager.context.save()
            NotificationCenter.default.post(name: NSNotification.Name.EX.coreDataChanged, object: nil, userInfo: nil)
            return true
        } catch {
            EZAlertController.alert("数据删除失败", message: error.localizedDescription)
        }
        return false
    }
    
    func updateReminder(_ areminder:Reminder,name:String?, note:String?, fireDate:Date?,
                        repeatType:Int16,shouldNoti:Bool ,shouldCalendar:Bool = false) -> Bool{
        areminder.name = name
        areminder.note = note
        areminder.fireDate = fireDate
        areminder.repeatType = repeatType
        areminder.notify = shouldNoti
        areminder.calendar = shouldCalendar
        areminder.createDate = Date.init(timeIntervalSinceNow: 0)
        do {
            try self.cdManager.context.save()
            NotificationCenter.default.post(name: NSNotification.Name.EX.coreDataChanged, object: nil, userInfo: nil)
        } catch  {
            EZAlertController.alert("数据库更新失败", message: error.localizedDescription)
            return false
        }
        return true
    }
    
    func qurryAllData() ->[Reminder]? {
        let reqest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Reminder")
        reqest.sortDescriptors = [NSSortDescriptor.init(key: "createDate", ascending: true)]
        do {
            if let results = try self.cdManager.context.fetch(reqest) as? [Reminder]{
                print(results)
                return results
            }
        } catch  {
            EZAlertController.alert("数据库查询失败", message: error.localizedDescription)
        }
        return nil
        
    }
}

extension NSNotification.Name{
    struct EX {
        static let coreDataChanged = NSNotification.Name.init("coreDataChanged")
    }
}
