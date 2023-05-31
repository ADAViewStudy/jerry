//
//  StopWatchViewModel.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/31.
//

import SwiftUI
import Combine

class StopwatchViewModel: ObservableObject {
    // Timer를 위한 publisher와 상태 변수
    @Published var secondsElapsed:TimeInterval = 0
    @Published var timeStops: TimeInterval = 0
    @Published var stopArr: [TimeInterval] = []
    private var timer: AnyCancellable?
    
    // 스탑워치 시작
    func start() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.secondsElapsed += 0.01
                self?.timeStops += 0.01
            }
    }
    func save() {
        stopArr.append(timeStops)
        timeStops = 0
        
    }
    
    func reset() {
        print("reset")
        timer?.cancel()
        timer = nil
        secondsElapsed = 0
        timeStops = 0
        stopArr = []
    }
    
    // 스탑워치 정지
    func stop() {
        timer?.cancel()
//        timer = nil
    }
}
