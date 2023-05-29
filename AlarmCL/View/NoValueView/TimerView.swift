//
//  TimerView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct TimerView: View {
    @State var time = Date()
    @State var sec = 0
    var body: some View {
        VStack {
            Picker("", selection: $sec) {
                HStack {
                    Text("2@")
                }
                Text("2@")
            }
            .pickerStyle(.wheel)
            
            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
            
        }
    }
}



struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

