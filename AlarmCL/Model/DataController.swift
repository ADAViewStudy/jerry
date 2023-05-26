//
//  DataController.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/21.
//

import Foundation
import CoreData
import SwiftUI

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
    
    func addAlarm(time: Date, label: String, freq: String, sound: String, enable: Bool, reAlarm: Bool, context: NSManagedObjectContext) {
        let alarm = Alarm(context: context)
        alarm.id = UUID()
        alarm.time = time
        alarm.label = label
        alarm.freq = freq
        alarm.sound = sound
        alarm.reAlarm = reAlarm
        alarm.enable = enable
        
        save(context: context)
    }
    
    func editAlarm(alarm: Alarm,time: Date, label: String, freq: String, sound: String, enable: Bool, reAlarm: Bool, context: NSManagedObjectContext) {
        alarm.time = time
        alarm.label = label
        alarm.freq = freq
        alarm.sound = sound
        alarm.reAlarm = reAlarm
        alarm.enable = enable
        
        save(context: context)
    }
    
    func deleteAlarm(alarm: Alarm, context: NSManagedObjectContext) {
            context.delete(alarm)
            save(context: context)
        }
    
    func deleteAlarmIndex(alarms: FetchedResults<Alarm> ,offsets: IndexSet, context: NSManagedObjectContext) {
        withAnimation {
            offsets.map { alarms[$0] }.forEach(context.delete)
            save(context: context)
        }
    }
    
    func addWorldTime(time: Date, location: String, context: NSManagedObjectContext) {
        let world = WorldTime(context: context)
        world.id = UUID()
        world.time = time
        world.location = location
        
        save(context: context)
    }
    
    func editWorldTime(worldTime: WorldTime, time: Date, location: String, context: NSManagedObjectContext) {
        worldTime.time = time
        worldTime.location = location
        
        save(context: context)
    }
    
    func deleteWorldTime(worldTime: WorldTime, context: NSManagedObjectContext) {
            context.delete(worldTime)
            save(context: context)
        }
    
    func deleteWorldTimeIndex(worldTime: FetchedResults<WorldTime> ,offsets: IndexSet, context: NSManagedObjectContext) {
        withAnimation {
            offsets.map { worldTime[$0] }.forEach(context.delete)
            save(context: context)
        }
    }
    
    func moveWorldTime(worldTime: FetchedResults<WorldTime>, from source: IndexSet, to destination: Int, context:NSManagedObjectContext) {
        // Convert the FetchedResults to a mutable array
        var mutableItems = Array(worldTime)
        // Rearrange the items based on the source and destination indices
        mutableItems.move(fromOffsets: source, toOffset: destination)

        // Update the order property of the items in Core Data
        for (index, item) in mutableItems.enumerated() {
            item.order = Int16(index)
        }
        
        save(context: context)
    }

    
    
}
