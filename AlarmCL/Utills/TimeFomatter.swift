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
