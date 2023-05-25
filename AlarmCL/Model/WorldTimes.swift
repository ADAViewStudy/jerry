//
//  WorldTimes.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import Foundation

struct WorldTimes: Hashable {
    let timeZone: TimeZone
    var currentTime: Date {
        return Date().addingTimeInterval(TimeInterval(timeZone.secondsFromGMT()))
    }
    
    init(timeZone: TimeZone) {
        self.timeZone = timeZone
    }
}

// Get all known time zone identifiers
func wTimes() -> [WorldTimes] {
    let allTimeZones = TimeZone.knownTimeZoneIdentifiers
    var worldtimes:[WorldTimes] = []
    // Create an array of WorldTime objects with time zones
    for identifier in allTimeZones {
        if let timeZone = TimeZone(identifier: identifier) {
            let worldTime = WorldTimes(timeZone: timeZone)
            worldtimes.append(worldTime)
        }
    }
    return worldtimes
}


