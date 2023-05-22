//
//  Alarm+CoreDataProperties.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/22.
//
//

import Foundation
import CoreData


extension Alarm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alarm> {
        return NSFetchRequest<Alarm>(entityName: "Alarm")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var time: Date?
    @NSManaged public var freq: String?
    @NSManaged public var label: String?
    @NSManaged public var sound: String?
    @NSManaged public var enable: Bool

}


