//
//  Alarm.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import Foundation

struct Alarm {
    var mainTime: Date
    var time: String
    var meridiem: String
    var cycle: String
    var label: String
    var sound: String
    var reTime: Bool
    
    init(mainTime: Date, cycle: String, label: String, sound: String, reTime: Bool) {
        self.mainTime = mainTime
        self.time = timeFormatter.string(from: mainTime)
        self.meridiem = meridiemFormatter.string(from: mainTime)
        self.cycle = cycle
        self.label = label
        self.sound = sound
        self.reTime = reTime
    }
}
