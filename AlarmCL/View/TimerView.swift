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
    @State var time = Date()
    @State var sec = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                CustomPicker(sec: $sec)
                Text("시간")
                    .offset(x: -70)
                Text("분")
                    .offset(x: 23)
                Text("초")
                    .offset(x: 125)
            }
            HStack {
                Button("취소") {
                    isRunning = false
                }.foregroundColor(.gray)
                    .opacity(isRunning ? 0.6:0.3)
                Spacer()
                Button(isRunning ? "일시정지":"시작") {
                    isRunning.toggle()
                }.foregroundColor(.green)
                    .opacity(0.6)
            }.buttonStyle(CircleStyle())
            .padding()
            List {
                HStack {
                    Text("타이머 종료 시\(sec)")
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
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}



