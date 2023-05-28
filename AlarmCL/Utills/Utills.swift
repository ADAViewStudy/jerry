//
//  Utills.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/28.
//

import Foundation

func wTimes() -> [WorldTimes] {
    let allTimeZones = TimeZone.knownTimeZoneIdentifiers
    var worldtimes:[WorldTimes] = []
    // Create an array of WorldTime objects with time zones
    for identifier in allTimeZones {
        if let timeZone = TimeZone(identifier: identifier) {
            let worldTime = WorldTimes(timeZone: timeZone, city: String(timeZone.identifier.split(separator: "/").last!), identifier: identifier)
            worldtimes.append(worldTime)
        }
    }
    return worldtimes.sorted { $0.city < $1.city }
}

func splitIntoSections(_ sortedItems: [WorldTimes]) -> [[WorldTimes]] {
    var sections: [[WorldTimes]] = []
    var currentSection: [WorldTimes] = []
    var previousFirstLetter = ""
    
    for item in sortedItems {
        let firstLetter = String(item.city.prefix(1))
        
        if firstLetter != previousFirstLetter {
            if !currentSection.isEmpty {
                sections.append(currentSection)
            }
            currentSection = []
        }
        
        currentSection.append(item)
        previousFirstLetter = firstLetter
    }
    
    if !currentSection.isEmpty {
        sections.append(currentSection)
    }
    
    return sections
}

func timeDifference(currentTimeZone: TimeZone, selectedTimeZone: TimeZone) -> String {
    let currentOffset = currentTimeZone.secondsFromGMT(for: Date())
    let selectedOffset = selectedTimeZone.secondsFromGMT(for: Date())
    let difference = selectedOffset - currentOffset
    
    if difference >= 0 {
        print("")
        return String("+\(difference/3600)")
    }
    return String(difference / 3600)
}

func compareDates(currentDate: Date, identifier: String) -> String {
    guard let timezone = TimeZone(identifier: identifier) else {return "error"}
    
//    let secondsFromGMT = timezone!.secondsFromGMT(for: currentDate)
//    let localizedDate = currentDate.addingTimeInterval(TimeInterval(secondsFromGMT))
    
    
    let localizedDate = currentDate.inTimeZone(timezone)
    
    
    print(localizedDate)
    let cal = Calendar.current.compare(currentDate, to: localizedDate,toGranularity: .day)
    
    switch cal {
    case .orderedSame:
        return "오늘"
    case .orderedDescending:
        return "어제"
    case .orderedAscending:
        return "내일"
    }
    
//    
//    if Calendar.current.isDateInToday(localizedDate) {
//        print("today")
//        return "오늘"
//    } else if Calendar.current.isDateInYesterday(localizedDate) {
//        print("yesterday")
//        return "어제"
//    } else if Calendar.current.isDateInTomorrow(localizedDate) {
//        print("tomorrow")
//        return "내일"
//    }
    return "err"

}


func stringToArray(string: String) -> [String] {
    return string.components(separatedBy: " ")
}

func arrayToString(array: [String]) -> String {
    return array.joined(separator: " ")
}

func sortWeek(cycle: [String]) -> [String] {
    let arr = cycle.sorted {
        guard let first = weekOrder.firstIndex(of: $0), let second = weekOrder.firstIndex(of: $1) else { return false }
        return first < second
    }
    return arr
}



extension Date {
    func inTimeZone(_ timezone: TimeZone) -> Date {
        let secondsFromGMT = timezone.secondsFromGMT(for: self)
        return addingTimeInterval(TimeInterval(secondsFromGMT))
    }
}
