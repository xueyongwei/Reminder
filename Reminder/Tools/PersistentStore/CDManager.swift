//
//  CDManager.swift
//  Reminder
//
//  Created by 薛永伟 on 2018/10/12.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit
import CoreData

class CDManager: NSObject {
    
    static let shared = CDManager()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let url = Bundle.main.url(forResource: "Model", withExtension: "momd")
        let model = NSManagedObjectModel.init(contentsOf: url!)
        return model!
    }()
    
    lazy var documentDirectoryURL: URL? = {
        var url = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        return url
    }()
    
    lazy var persistentStoreCoorninator: NSPersistentStoreCoordinator = {
        let coorninator = NSPersistentStoreCoordinator.init(managedObjectModel: self.managedObjectModel)
        let sqlUrl = self.documentDirectoryURL?.appendingPathComponent("CoreData.sqlite")
        do {
            try coorninator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: sqlUrl, options: nil)
        }catch{
            print("无法指定存储类型为sqlite！")
        }
        
        return coorninator
    }()
    
    lazy var context: NSManagedObjectContext = {
        let context = NSManagedObjectContext.init(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoorninator
        return context
    }()
}

extension CDManager {
    func setUp(){
        
    }
}
