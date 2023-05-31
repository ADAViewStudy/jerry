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
//    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
}
var meridiemFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "aa"
    return formatter
}

func worldtimeFormatter(for timeZoneIdentifier: String, currentTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "aa"
        formatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
    return formatter.string(from: currentTime)
    }

func worldmeridiemFormatter(for timeZoneIdentifier: String, currentTime: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        formatter.timeZone = TimeZone(identifier: timeZoneIdentifier)
    return formatter.string(from: currentTime)
    }

