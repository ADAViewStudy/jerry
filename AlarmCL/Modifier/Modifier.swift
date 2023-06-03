//
//  Modifier.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

////import Foundation
//import SwiftUI
//
//// Custom GaugeStyle
//struct CustomGaugeStyle: GaugeStyle {
//    func makeBody(configuration: GaugeStyleConfiguration) -> some View {
//        ZStack {
//            Circle()
//                .stroke(Color.gray, lineWidth: 10)
//                .frame(width: 300, height: 300)
//                .opacity(0.6)
//            Circle()
//                .trim(from: 0, to: CGFloat(configuration.value))
//                .stroke(Color.accentColor, lineWidth: 10)
//                .frame(width: 300, height: 300)
//                .rotationEffect(Angle(degrees: -90))
//                .opacity(0.6)
//            Text("\(Int(configuration.value))")
//                .font(.title)
//        }
//    }
//}
