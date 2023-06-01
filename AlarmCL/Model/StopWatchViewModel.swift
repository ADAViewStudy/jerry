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
    
//    @FetchRequest(entity: StopWatch.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StopWatch.id, ascending: false)]) var stopwatch: FetchedResults<StopWatch>
    // Timer를 위한 publisher와 상태 변수
    @Published var secondsElapsed:TimeInterval = 0
    @Published var timeStops: TimeInterval = 0
    @Published var stopArr: [TimeInterval] = []
    private var timer: AnyCancellable?
    
    // 스탑워치 시작
    func start(managedObjContext: NSManagedObjectContext) {
//        DataController.shared.startStopWatch(time: secondsElapsed, laptime: timeStops, arr: stopArr, context: managedObjContext)
        timer = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.secondsElapsed += 0.01
                self?.timeStops += 0.01
            }
    }
    func save(managedObjContext: NSManagedObjectContext) {
//        DataController.shared.runStopWatch(stopwatch: stopwatch.first, time: secondsElapsed, laptime: timeStops, arr: stopArr, context: managedObjContext)
        stopArr.append(timeStops)
        timeStops = 0
        
    }
    
    func reset(managedObjContext: NSManagedObjectContext) {
        print("reset")
        timer?.cancel()
        timer = nil
        secondsElapsed = 0
        timeStops = 0
        stopArr = []
//        DataController.shared.resetStopWatch(stopwatch: stopwatch.first, context: managedObjContext)
    }
    
    // 스탑워치 정지
    func stop() {
        timer?.cancel()
//        timer = nil
    }
}


extension DataController {
    func startStopWatch(time: TimeInterval, laptime: TimeInterval, arr: [TimeInterval], context: NSManagedObjectContext) {
        let stopwatch = StopWatch(context: context)
        stopwatch.id = UUID()
        stopwatch.lapArr = arr.map{ Double($0) }
        stopwatch.lapTime = Double(laptime)
        stopwatch.time = Double(time)
        
        save(context: context)
    }
    
    func runStopWatch(stopwatch: StopWatch?, time: TimeInterval, laptime: TimeInterval, arr: [TimeInterval], context: NSManagedObjectContext) {
        guard let stopwatch = stopwatch else { return }
        stopwatch.lapArr = arr.map{ Double($0) }
        stopwatch.lapTime = Double(laptime)
        stopwatch.time = Double(time)
        
        save(context: context)
    }
    
    func resetStopWatch(stopwatch: StopWatch?, context: NSManagedObjectContext) {
        guard let stopwatch = stopwatch else { return }
        stopwatch.lapArr = []
        stopwatch.lapTime = 0
        stopwatch.time = 0
        
        save(context: context)
    }
}
