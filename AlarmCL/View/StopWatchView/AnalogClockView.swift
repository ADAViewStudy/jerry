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
            Text("\(stringFromTimeInterval(_:time))")
                .offset(y: 60)
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
