//
//  StopWatchViewModel.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/31.
//

import SwiftUI
import CoreData
import Combine

class StopwatchViewModel: ObservableObject {
    
    // Timer를 위한 publisher와 상태 변수
    @Published var secondsElapsed:TimeInterval = 0
    @Published var timeStops: TimeInterval = 0
    @Published var stopArr: [TimeInterval] = []
    private var timer: AnyCancellable?
    
    
    // 스탑워치 시작
    func start(stopwatch: StopWatch? = nil, managedObjContext: NSManagedObjectContext) {
        if stopwatch == nil&&(secondsElapsed == 0) {
            DataController.shared.startStopWatch(time: secondsElapsed, laptime: timeStops, arr: stopArr, context: managedObjContext)
        } else {
            DataController.shared.runStopWatch(stopwatch: stopwatch, time: secondsElapsed, laptime: timeStops, arr: stopArr, isRunning: true, context: managedObjContext)
        }
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.secondsElapsed += 0.01
                self?.timeStops += 0.01
            }
    }
    func save(stopwatch: StopWatch,isRuning: Bool,managedObjContext: NSManagedObjectContext) {
        stopArr.append(timeStops)
        timeStops = 0
        DataController.shared.lapStopWatch(stopwatch: stopwatch, time: secondsElapsed, laptime: timeStops, arr: stopArr,isRunning: isRuning, context: managedObjContext)
        
    }
    
    func reset(stopwatch: StopWatch,managedObjContext: NSManagedObjectContext) {
        timer?.cancel()
        timer = nil
        secondsElapsed = 0
        timeStops = 0
        stopArr = []
        DataController.shared.resetStopWatch(stopwatch: stopwatch, context: managedObjContext)
    }
    
    // 스탑워치 정지
    func stop(stopwatch: StopWatch, context: NSManagedObjectContext) {
        timer?.cancel()
        DataController.shared.runStopWatch(stopwatch: stopwatch, time: secondsElapsed, laptime: timeStops, arr: stopArr, isRunning: false, context: context)
//        timer = nil
    }
}


extension DataController {
    func startStopWatch(time: TimeInterval, laptime: TimeInterval, arr: [TimeInterval], context: NSManagedObjectContext) {
        let stopwatch = StopWatch(context: context)
        stopwatch.id = UUID()
        stopwatch.lapArr = arr
        stopwatch.lapTime = laptime
        stopwatch.time = time
        stopwatch.isRunning = true
        stopwatch.startTime = Date()
        stopwatch.lapStartTime = Date()
        
        save(context: context)
    }
    
    func lapStopWatch(stopwatch: StopWatch?, time: TimeInterval, laptime: TimeInterval, arr: [TimeInterval],isRunning : Bool , context: NSManagedObjectContext) {
        guard let stopwatch = stopwatch else { return }
        stopwatch.lapArr = arr
        stopwatch.lapTime = laptime
        stopwatch.time = time
        stopwatch.isRunning = isRunning
        stopwatch.lapStartTime = Date()
        
        save(context: context)
    }
    
    func runStopWatch(stopwatch: StopWatch?, time: TimeInterval, laptime: TimeInterval, arr: [TimeInterval],isRunning : Bool , context: NSManagedObjectContext) {
        guard let stopwatch = stopwatch else { return }
        stopwatch.lapArr = arr
        stopwatch.lapTime = laptime
        stopwatch.time = time
        stopwatch.isRunning = isRunning
        
        save(context: context)
    }
    
    func resetStopWatch(stopwatch: StopWatch?, context: NSManagedObjectContext) {
        guard let stopwatch = stopwatch else { return }
        context.delete(stopwatch)
        
        save(context: context)
    }
}
