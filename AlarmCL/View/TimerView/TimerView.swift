//
//  TimerView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct TimerView: View {
    
    @State private var isRunning = false
    @State private var isShow = false
    @State private var countSec = 0.0
    @State var sec = 0.0
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            if !isRunning&&(sec == 0) {
                ZStack {
                    CustomPicker(sec: $countSec)
                    Text("시간")
                        .offset(x: -70)
                    Text("분")
                        .offset(x: 23)
                    Text("초")
                        .offset(x: 125)
                }.frame(width: 350,height: 350)
            } else {
                GaugeTimerView(sec: $sec, isRunning: $isRunning)
                    .transition(.opacity)
                    .frame(width: 350,height: 350)
            }
            HStack {
                Button("취소") {
                    withAnimation {
                        isRunning = false
                        sec = 0
                    }
                }.foregroundColor(.gray)
                    .opacity(isRunning ? 0.6:0.3)
                Spacer()
                Button(isRunning ? "일시정지":(sec > 0 ? "재개":"시작")) {
                    withAnimation {
                        isRunning.toggle()
                        if isRunning && sec == 0 {
                            sec = countSec
                        }
                    }
                }.foregroundColor(isRunning ? .accentColor:.green)
                    .opacity(countSec==0 ? 0.3:0.6)
                    .disabled(countSec==0 ? true:false)
            }.buttonStyle(CircleStyle())
            .padding()
            List {
                HStack {
                    Text("타이머 종료 시")
                    Spacer()
                    Button {
                        isShow = true
                    } label: {
                        HStack {
                            Text("전파 탐지기")
                            Image(systemName: "chevron.right")
                                .imageScale(.small)
                        }.foregroundColor(.gray)
                    }

                }
            }
        }
        .sheet(isPresented: $isShow) {
            Text("준비중 이야!")
        }
        .onReceive(timer) { _ in
            if isRunning && sec > 0 {
                sec -= 0.01
                print("\(sec)")
            } else if !isRunning && sec > 0 {
                isRunning = false
            } else {
                isRunning = false
                sec = 0
            }
        }
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}



