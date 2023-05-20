//
//  FreqView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/20.
//

import SwiftUI

struct FreqView: View {
    
    var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    @State private var selectedDays = Set<String>()
    @Binding var newAlarm: Alarm
    
    var body: some View {
        List(daysOfWeek, id: \.self) { day in
            Button(action: {
                if selectedDays.contains(day) {
                    selectedDays.remove(day)
                } else {
                    selectedDays.insert(day)
                }
            }) {
                HStack {
                    Text(day+"요일마다")
                    Spacer()
                    if selectedDays.contains(day) {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .foregroundColor(.primary)
        }
        .onDisappear() {
            newAlarm.cycle = Array(selectedDays)
            newAlarm.sortWeek()
        }
        .onAppear() {
            selectedDays = Set(newAlarm.cycle)
        }
        
    }
}




//struct FreqView_Previews: PreviewProvider {
//    static var previews: some View {
//        FreqView()
//            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
//            .accentColor(Color.orange) // here you can set your custom color
//    }
//}
