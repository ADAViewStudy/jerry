//
//  File.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct AddAlarmView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTime = Date()
    @State private var labelText = ""
    @State var isOn: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .labelsHidden() // Hides the label
                    .datePickerStyle(WheelDatePickerStyle())
                List {
                    Button {
                        //handleShowFrequencyView
                    } label: {
                        HStack {
                            Text("반복")
                                .foregroundColor(.white)
                            Spacer()
                            Text("안함")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.gray)
                    }
                    HStack {
                        Text("레이블")
                        TextField("알람", text: $labelText)
                            .multilineTextAlignment(.trailing)
                    }
                    Button {
                        //handleShowFrequencyView
                    } label: {
                        HStack {
                            Text("사운드")
                                .foregroundColor(.white)
                            Spacer()
                            Text("전파 탐지기")
                            Image(systemName: "chevron.right")
                        }
                        .foregroundColor(.gray)
                    }
                    HStack {
                        Text("다시 알림")
                        Toggle(isOn: $isOn) {
                            
                        }
                    }
                }
            }
            .toolbar() {
                ToolbarItem {
                    Button {
                        //handleApendAlarm
                    } label: {
                        Text("저장")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
            }
            .navigationTitle("알람 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct AddAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AddAlarmView()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}
