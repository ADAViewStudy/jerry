//
//  GaugeTimerView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/06/03.
//

import SwiftUI

struct GaugeTimerView: View {
    
    @State var maxSec: Double = 0
    @Binding var sec: Double
    @Binding var isRunning: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 10)
                .frame(width: 300, height: 300)
                .opacity(0.6)
            Circle()
                .trim(from: 0, to: CGFloat(sec/maxSec))
                .stroke(Color.accentColor, lineWidth: 10)
                .frame(width: 300, height: 300)
                .rotationEffect(Angle(degrees: 270))
                .opacity(0.6)
            Text("\(stringFromTimeIntervalHMS(interval:sec))")
                .font(.system(size: 70))
                .fontWeight(.thin)
                .offset(y: -15)
            HStack {
                Image(systemName: "bell.fill")
                Text("\(addingTimeinterval(sec:sec))")
            }.offset(y: 45)
                .foregroundColor(.gray)
                .opacity(isRunning ? 1:0.3)
        }.onAppear() {
            maxSec = sec
        }
    }
    
    func addingTimeinterval(sec: Double) -> String {
        let date = Date().addingTimeInterval(sec)
        return meridiemFormatter.string(from: date) + " " + timeFormatter.string(from: date)
    }
}

//struct GaugeTimerView_Previews: PreviewProvider {
//    static var previews: some View {
//        GaugeTimerView()
//            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
//            .accentColor(Color.orange) // here you can set your custom color
//    }
//}
