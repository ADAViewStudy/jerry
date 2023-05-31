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
    
    let dateformat = DateFormatter()
    dateformat.dateFormat = "yyyy-MM-dd"
    dateformat.timeZone = .current
    
    let dateformat2 = DateFormatter()
    dateformat2.dateFormat = "yyyy-MM-dd"
    dateformat2.timeZone = timezone
    
    let sdate = dateformat.string(from: currentDate)
    let edate = dateformat2.string(from: currentDate)
    
    let comparisonResult = sdate.compare(edate, options: .numeric)

    if comparisonResult == .orderedAscending {
        return "내일"
    } else if comparisonResult == .orderedDescending {
        return "어제"
    } else {
        return "오늘"
    }
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


func stringFromTimeInterval(_ interval: TimeInterval) -> String {
    let intervalInt = Int(interval)
    let millisecondsInt = Int((interval - Double(intervalInt)) * 100)
    
    let minutes = intervalInt / 60
    let seconds = intervalInt % 60
    let milliseconds = millisecondsInt
    
    return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
}
