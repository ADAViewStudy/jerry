//
//  AnalogClockView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/31.
//

import SwiftUI

struct Clock: View {
    var time: TimeInterval
    var lapTime: TimeInterval?
    var body: some View {
        ZStack {
            if lapTime != nil {
                ForEach(0..<60*4) { tick in
                    self.tick(at: tick)
                }
            } else {
                ForEach(0..<60) { tick in
                    self.miniIick(at: tick)
                }
            }
            if lapTime != nil {
                Pointer()
                    .stroke(Color.blue, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(lapTime!) * 360/60))
                Pointer()
                    .stroke(Color.orange, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(time) * 360/60))
            } else {
                Pointer()
                    .fill(.orange)
                    .rotationEffect(Angle.degrees(Double(time) * 360/60))
                Pointer()
                    .stroke(Color.orange, lineWidth: 2)
                    .rotationEffect(Angle.degrees(Double(time) * 360/60))
            }
            Color.clear
            if lapTime != nil {
                Text("\(stringFromTimeInterval(_:time))")
                    .offset(y: 60)
            }
        }
    }
    
    func tick(at tick: Int) -> some View {
        let degree: Double = Double(-tick/20)*30
        return VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 20 == 0 ? 1 : 0.4)
                .frame(width: 2, height: tick % 4 == 0 ? 15 : 7)
            if tick % 20 == 0 {
                if tick == 0 {
                    Text("60")
                } else {
                    Text("\(tick/4)")
                        .rotationEffect(.degrees(degree))
                }
            }
            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(tick)/240 * 360))
    }
    func miniIick(at tick: Int) -> some View {
        let degree: Double = Double(-tick/10)*60
        return VStack {
            Rectangle()
                .fill(Color.primary)
                .opacity(tick % 10 == 0 ? 1 : 0.4)
                .frame(width: 1, height: tick % 2 == 0 ? 10 : 5)
            if tick % 10 == 0 {
                if tick == 0 {
                    Text("30")
                        .font(.system(size: 7))
                } else {
                    Text("\(tick/2)")
                        .rotationEffect(.degrees(degree))
                        .font(.system(size: 7))
                }
            }
            Spacer()
        }
        .rotationEffect(Angle.degrees(Double(tick)/60 * 360))
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
