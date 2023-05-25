//
//  TimeFomatter.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/19.
//

import Foundation

let weekOrder = ["월", "화", "수", "목", "금", "토", "일"]

var timeFormatter : DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = "hh:mm"
    return formatter
}
var meridiemFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "aa"
    return formatter
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
