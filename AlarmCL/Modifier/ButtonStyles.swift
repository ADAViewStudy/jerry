//
//  StyleModifier.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/31.
//

import Foundation
import SwiftUI

struct CircleStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill()
            .overlay(
                Circle()
                    .stroke(Color.black,lineWidth: 2)
                    .foregroundColor(.white)
                    .padding(3)
            )
            .overlay(
                configuration.label
                    .foregroundColor(.white)
            )
            .frame(width: 75, height: 75)
    }
}
