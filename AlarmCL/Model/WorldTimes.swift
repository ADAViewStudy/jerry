//
//  WorldTimes.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import Foundation

struct WorldTimes: Hashable {
    let timeZone: TimeZone
    let city: String
    var currentTime: Date {
        return Date().addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
    }
}

// Get all known time zone identifiers
func wTimes() -> [WorldTimes] {
    let allTimeZones = TimeZone.knownTimeZoneIdentifiers
    var worldtimes:[WorldTimes] = []
    // Create an array of WorldTime objects with time zones
    for identifier in allTimeZones {
        if let timeZone = TimeZone(identifier: identifier) {
            let worldTime = WorldTimes(timeZone: timeZone, city: String(timeZone.identifier.split(separator: "/").last!))
            worldtimes.append(worldTime)
        }
    }
    return worldtimes
}


