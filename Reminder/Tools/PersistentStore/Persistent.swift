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
            ReminderNotification.center.addNoti(with: areminder)
        } catch  {
            EZAlertController.alert("Storage failure", message: error.localizedDescription)
            return false
        }
        return true
    }
    
    func deleteReminder(_ reminder:Reminder) -> Bool{
        let deleteReminder = reminder
        ReminderNotification.center.remove(with: deleteReminder)
        self.cdManager.context.delete(reminder)
        
        do {
            try self.cdManager.context.save()
            NotificationCenter.default.post(name: NSNotification.Name.EX.coreDataChanged, object: nil, userInfo: nil)
            
            return true
        } catch {
            EZAlertController.alert("Delete failed", message: error.localizedDescription)
        }
        return false
    }
    
    func updateReminder(_ areminder:Reminder,name:String?, note:String?, fireDate:Date?,
                        repeatType:Int16,shouldNoti:Bool ,shouldCalendar:Bool = false) -> Bool{
        ReminderNotification.center.remove(with: areminder)
        areminder.name = name
        areminder.note = note
        areminder.fireDate = fireDate
        areminder.repeatType = repeatType
        areminder.notify = shouldNoti
        areminder.calendar = shouldCalendar
        areminder.createDate = Date.init(timeIntervalSinceNow: 0)
        ReminderNotification.center.addNoti(with: areminder)
        do {
            try self.cdManager.context.save()
            NotificationCenter.default.post(name: NSNotification.Name.EX.coreDataChanged, object: nil, userInfo: nil)
            
        } catch  {
            EZAlertController.alert("Update failed", message: error.localizedDescription)
            return false
        }
        return true
    }
    
    func qurryAllReminder() ->[Reminder]? {
        let reqest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Reminder")
        reqest.sortDescriptors = [NSSortDescriptor.init(key: "createDate", ascending: false)]
        do {
            if let results = try self.cdManager.context.fetch(reqest) as? [Reminder]{
                print(results)
                return results
            }
        } catch  {
            EZAlertController.alert("Fetch failed", message: error.localizedDescription)
        }
        return nil
        
    }
    
  
    func addHistory(name:String?,note:String?,createDate:Date?,fireDate:Date?) {
        let ahistory = NSEntityDescription.insertNewObject(forEntityName: "History", into: self.cdManager.context) as! History
        ahistory.name = name
        ahistory.note = note
        ahistory.createDate = createDate
        ahistory.fireDate = fireDate
        do {
            try self.cdManager.context.save()
        } catch {
            print("fialed = \(error.localizedDescription)")
        }
    }
    
    func queryAllHistory()->[History]?{
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "History")
        request.sortDescriptors = [NSSortDescriptor.init(key: "createDate", ascending: false)]
        do {
            let results = try self.cdManager.context.fetch(request) as? [History]
            return results
        } catch  {
            print("results fetch error:\(error.localizedDescription)")
            
        }
        return nil
    }
    
}

extension NSNotification.Name{
    struct EX {
        static let coreDataChanged = NSNotification.Name.init("coreDataChanged")
    }
}
