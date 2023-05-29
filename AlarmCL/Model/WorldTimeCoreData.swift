//
//  WorldTimeCoreData.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/29.
//

import SwiftUI
import CoreData


extension DataController {
    func addWorldTime(diff: String ,location: String,identifier: String, context: NSManagedObjectContext) {
        let world = WorldTime(context: context)
        world.id = UUID()
        world.diffTime = diff
        world.location = location
        world.identifier = identifier
        
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
