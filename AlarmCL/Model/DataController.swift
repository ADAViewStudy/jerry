//
//  DataController.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/21.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()
    let container = NSPersistentContainer(name: "AlarmsModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("DEBUG ====\(error.localizedDescription)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("DEBUG == Save !")
        } catch {
            print("DEBUG ==== Save Fail !")
        }
    }
    
    func addAlarm(time: Date, label: String, freq: String, sound: String, enable: Bool, context: NSManagedObjectContext) {
        let alarm = Alarm(context: context)
        alarm.id = UUID()
        alarm.time = time
        alarm.label = label
        alarm.freq = freq
        alarm.sound = sound
        alarm.enable = enable
        
        save(context: context)
    }
    
    func editAlarm(alarm: Alarm,time: Date, label: String, freq: String, sound: String, enable: Bool, context: NSManagedObjectContext) {
        alarm.time = time
        alarm.label = label
        alarm.freq = freq
        alarm.sound = sound
        alarm.enable = enable
        
        save(context: context)
    }
    
    
}
