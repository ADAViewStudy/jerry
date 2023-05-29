//
//  Extension.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/29.
//

import Foundation

extension Date {
    func inTimeZone(_ timezone: TimeZone) -> Date {
        let secondsFromGMT = timezone.secondsFromGMT(for: self)
        return addingTimeInterval(TimeInterval(secondsFromGMT))
    }
}
