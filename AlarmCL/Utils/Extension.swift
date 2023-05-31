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

extension CGRect {
    var center: CGPoint {
        CGPoint(x: midX, y: midY)
    }
    
    init(center: CGPoint, radius: CGFloat) {
        self = CGRect(
            x: center.x - radius,
            y: center.y - radius,
            width: radius * 2,
            height: radius * 2
        )
    }
}
