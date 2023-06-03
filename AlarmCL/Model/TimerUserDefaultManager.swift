//
//  TimerUserDefaultManager.swift
//  AlarmCL
//
//  Created by 주환 on 2023/06/04.
//

import Foundation

class TimerUserDefaultManager {
    // UserDefaults의 instance
    static let shared = TimerUserDefaultManager()
    private let defaults = UserDefaults.standard

    // 각각의 값에 대한 키
    private let doubleKeyOne = "CountSec"
    private let doubleKeyTwo = "Sec"
    private let dateKey = "StartDate"
    private let boolKey = "IsRunning"
    
    // 저장 메서드
    func save(countSec: Double, sec: Double, startDate: Date, isRunning: Bool) {
        defaults.set(countSec, forKey: doubleKeyOne)
        defaults.set(sec, forKey: doubleKeyTwo)
        defaults.set(startDate, forKey: dateKey)
        defaults.set(isRunning, forKey: boolKey)
    }
    
    // 값 가져오기 메서드
    func getValues() -> (Double?, Double?, Date?, Bool?) {
        let doubleOne = defaults.double(forKey: doubleKeyOne)
        let doubleTwo = defaults.double(forKey: doubleKeyTwo)
        let date = defaults.object(forKey: dateKey) as? Date
        let bool = defaults.bool(forKey: boolKey)
        
        return (doubleOne, doubleTwo, date, bool)
    }
    
    // 값 삭제 메서드
    func removeValues() {
        defaults.removeObject(forKey: doubleKeyOne)
        defaults.removeObject(forKey: doubleKeyTwo)
        defaults.removeObject(forKey: dateKey)
        defaults.removeObject(forKey: boolKey)
    }
}
