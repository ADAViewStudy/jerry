//
//  StopWatchView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI
import CoreData

struct StopWatchView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(entity: StopWatch.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StopWatch.id, ascending: false)]) var stopwatch: FetchedResults<StopWatch>
    
    @StateObject private var viewModel = StopwatchViewModel()
    @State private var isRunning = false
    @State private var selectionIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectionIndex) {
                Text("\(stringFromTimeInterval(_:viewModel.secondsElapsed))")
                    .fontWeight(.thin)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.system(size: 90))
                    .tag(0)
                ZStack {
                    Clock(time: viewModel.secondsElapsed,lapTime: viewModel.timeStops)
                        .frame(width: 300,height: 300)
                    Clock(time: viewModel.secondsElapsed/60)
                        .frame(width: 75,height: 75)
                        .offset(y: -50)
                }.tag(1)
            }.tabViewStyle(.page)
                .frame(width: 500,height: 380)
            VStack {
                HStack {
                    Button(!isRunning&&(!(viewModel.secondsElapsed==0)) ? "재설정":"랩") {
                        isRunning ? viewModel.save(stopwatch: stopwatch.first!, isRuning: isRunning,managedObjContext: managedObjContext): viewModel.reset(stopwatch: stopwatch.first!,managedObjContext: managedObjContext)
                    }.foregroundColor(.gray)
//                        .disabled(!isRunning&&(viewModel.secondsElapsed==0) ? true : false)
                        .opacity(!isRunning&&(viewModel.secondsElapsed==0) ? 0.3:0.6)
                    Spacer()
                    Button(isRunning ? "중단" : "시작") {
                        isRunning.toggle()
                        isRunning ? viewModel.start(stopwatch: stopwatch.first ?? nil,managedObjContext: managedObjContext) : viewModel.stop(stopwatch: stopwatch.first!,context: managedObjContext)
                    }.foregroundColor(isRunning ? .red: .green)
                        .opacity(0.6)
                }.buttonStyle(CircleStyle())
                    .padding([.leading,.trailing])
                Divider().padding(.leading)
                List {
                    if !(viewModel.secondsElapsed==0) {
                        HStack {
                            Text("랩\(viewModel.stopArr.count+1)")
                            Spacer()
                            Text("\(stringFromTimeInterval(_:viewModel.timeStops))")
                        }
                    }
                    ForEach(viewModel.stopArr.indices.reversed() ,id: \.self) { index in
                        HStack {
                            Text("랩\(index+1)")
                            Spacer()
                            Text("\(stringFromTimeInterval(_:viewModel.stopArr[Int(index)]))")
                        }.foregroundColor((2 <= viewModel.stopArr.count)&&viewModel.stopArr.min() == viewModel.stopArr[index] ? .green : (viewModel.stopArr.max() == viewModel.stopArr[index]&&(2<=viewModel.stopArr.count) ? .red: .white))
                    }
                }
                .listStyle(.plain)
            }.offset(y:-80)
        }
        .onAppear() {
//            print("옵셔널 풀기전 = \(stopwatch.count)")
            guard let stopwatch = stopwatch.first,
                  let start = stopwatch.startTime,
                  let lapstart = stopwatch.lapStartTime,
                  let laparr = stopwatch.lapArr else { return }
            viewModel.stopArr = laparr
            
            if stopwatch.isRunning {
                isRunning = stopwatch.isRunning
                viewModel.secondsElapsed = Date().timeIntervalSince(start)
                viewModel.timeStops = Date().timeIntervalSince(lapstart)
                viewModel.start(stopwatch: stopwatch,managedObjContext: managedObjContext)
            } else {
                isRunning = stopwatch.isRunning
                viewModel.secondsElapsed = stopwatch.time
                viewModel.timeStops = stopwatch.lapTime
            }
        }
        .onAppear() {
            selectionIndex = TimerUserDefaultManager.shared.getStopWatchSelection()
        }
        .onChange(of: selectionIndex) { newValue in
            TimerUserDefaultManager.shared.timewatchSelectionSave(selectionNum: newValue)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}



