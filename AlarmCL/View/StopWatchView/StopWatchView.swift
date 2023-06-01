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
                    .fontWeight(.light)
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
                        isRunning ? viewModel.save(managedObjContext: managedObjContext): viewModel.reset(managedObjContext: managedObjContext)
                    }.foregroundColor(.gray)
                        .disabled(!isRunning&&(viewModel.secondsElapsed==0) ? true : false)
                        .opacity(!isRunning&&(viewModel.secondsElapsed==0) ? 0.4:0.6)
                    Spacer()
                    Button(isRunning ? "중단" : "시작") {
                        isRunning.toggle()
                        isRunning ? viewModel.start(managedObjContext: managedObjContext) : viewModel.stop()
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
                        }
                    }
                }.listStyle(.plain)
            }.offset(y:-80)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}



