//
//  SoundSelectView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/20.
//

import SwiftUI

struct SoundSelectView: View {
    
    var daysOfWeek = ["sound1", "sound2", "sound3", "sound4", "sound5", "sound6", "sound7"]
    @State private var selectedDays = Set<String>()
    
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
                    Text(day)
                    Spacer()
                    if selectedDays.contains(day) {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .foregroundColor(.primary)
        }
        
    }
}




struct SoundSelectView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSelectView()
            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
            .accentColor(Color.orange) // here you can set your custom color
    }
}
