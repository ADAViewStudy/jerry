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
    
    var body: some View {
        VStack {
            Clock(time: viewModel.secondsElapsed,lapTime: viewModel.timeStops)
                .frame(width: 300,height: 300)
            
            HStack {
                Button(isRunning ? "렙":"재설정") {
                    isRunning ? viewModel.save(): viewModel.reset()
                }.foregroundColor(.gray)
                Spacer()
                Button(isRunning ? "중단" : "시작") {
                    isRunning.toggle()
                    isRunning ? viewModel.start() : viewModel.stop()
                }.foregroundColor(isRunning ? .red: .green)
            }.buttonStyle(CircleStyle())
                .padding()
            Divider()
            List {
                HStack {
                    Text("랩\(viewModel.stopArr.count+1)")
                    Spacer()
                    Text("\(viewModel.timeStops)")
                }
                ForEach(viewModel.stopArr.indices.reversed() ,id: \.self) { index in
                    HStack {
                        Text("랩\(index+1)")
                        Spacer()
                        Text("\(viewModel.stopArr[Int(index)])")
                    }
                }
            }.listStyle(.plain)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView()
    }
}

struct Clock: View {
    var time: TimeInterval
    var lapTime: TimeInterval?
    var body: some View {
        
        ZStack {
            ForEach(0..<60*4) { tick in
                self.tick(at: tick)
            }
            if lapTime != nil {
                Pointer()
                    .stroke(Color.blue, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(lapTime!) * 360/60))
            }
            Pointer()
                .stroke(Color.orange, lineWidth: 2)
                .rotationEffect(Angle.degrees(Double(time) * 360/60))
            Color.clear
        }
    }
    
    func tick(at tick: Int) -> some View {
        VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 20 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 4 == 0 ? 15 : 7)
            if tick % 20 == 0 {
                if tick == 0 {
                    Text("60")
                } else {
                    Text("\(tick/4)")
                }
            }
            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(tick)/240 * 360))
    }
}

struct Pointer: Shape {
    var circleRadius: CGFloat = 3
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY - circleRadius))
            p.addEllipse(in: CGRect(center: rect.center, radius: circleRadius))
            p.move(to: CGPoint(x: rect.midX, y: rect.midY + circleRadius))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.midY + rect.height / 10))
        }
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

struct CircleStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill()
            .overlay(
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .padding(4)
            )
            .overlay(
                configuration.label
                    .foregroundColor(.white)
            )
            .frame(width: 75, height: 75)
    }
}

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

