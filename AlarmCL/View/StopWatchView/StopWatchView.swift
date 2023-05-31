//
//  StopWatchView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct StopWatchView: View {
    @StateObject private var viewModel = StopwatchViewModel()
    @State private var isRunning = false
    @State private var selectionIndex = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectionIndex) {
                Text("@@")
                    .tag(0)
                Clock(time: viewModel.secondsElapsed,lapTime: viewModel.timeStops)
                    .frame(width: 300,height: 300)
                    .tag(1)
            }.tabViewStyle(.page)
                .frame(width: 300,height: 380)
            VStack {
                HStack {
                    Button(!isRunning&&(!(viewModel.secondsElapsed==0)) ? "재설정":"랩") {
                        isRunning ? viewModel.save(): viewModel.reset()
                    }.foregroundColor(!isRunning&&(viewModel.secondsElapsed==0) ? Color(UIColor.lightGray):Color(UIColor.darkGray))
                        .disabled(!isRunning&&(viewModel.secondsElapsed==0) ? true : false)
                    Spacer()
                    Button(isRunning ? "중단" : "시작") {
                        isRunning.toggle()
                        isRunning ? viewModel.start() : viewModel.stop()
                    }.foregroundColor(isRunning ? .red: .green)
                }.buttonStyle(CircleStyle())
                    .padding([.leading,.trailing])
                Divider().padding(.leading)
                List {
                    if !(viewModel.secondsElapsed==0) {
                        HStack {
                            Text("랩\(viewModel.stopArr.count+1)")
                            Spacer()
                            Text("\(viewModel.timeStops)")
                        }
                    }
                    ForEach(viewModel.stopArr.indices.reversed() ,id: \.self) { index in
                        HStack {
                            Text("랩\(index+1)")
                            Spacer()
                            Text("\(viewModel.stopArr[Int(index)])")
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



