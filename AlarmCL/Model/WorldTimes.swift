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
    let identifier: String
    var diffTime: String
    
    init(timeZone: TimeZone, city: String, identifier: String) {
        self.timeZone = timeZone
        self.city = city
        self.identifier = identifier
        self.diffTime = timeDifference(currentTimeZone: TimeZone.current, selectedTimeZone: self.timeZone)
    }
}


