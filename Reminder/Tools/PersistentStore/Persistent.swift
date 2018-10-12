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
    
}

extension Persistent {
    
    func addNewReminder(){
        let areminder = NSEntityDescription.insertNewObject(forEntityName: "Reminder", into: CDManager.shared.context) as! Reminder
        
    }
}
