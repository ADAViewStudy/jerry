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
    @State var isOn = true
    @State private var firstAppear = true
    
    var onAdd: ((Alarm) -> Void)? = nil
    var onEdit: ((Alarm) -> Void)? = nil
    var alarmToEdit: Alarm? = nil
    @State var newAlarm: Alarm = Alarm(mainTime: Date(), cycle: [], label: "", sound: "", reTime: false)
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .labelsHidden() // Hides the label
                    .datePickerStyle(WheelDatePickerStyle())
                List {
                    NavigationLink {
                        FreqView(newAlarm: $newAlarm)
                            .navigationTitle("반복")
                    } label: {
                        HStack {
                            Text("반복")
                                .foregroundColor(.white)
                            Spacer()
                            if newAlarm.cycle.isEmpty {
                                Text("안함")
                            } else if newAlarm.cycle.count == 7{
                                Text("매일")
                            }
                            else {
                                ForEach(newAlarm.cycle.indices, id: \.self) { index in
                                    Text(newAlarm.cycle[index].prefix(1))
                                }
                            }
                        }
                        .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("레이블")
                        TextField("알람", text: $labelText)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    NavigationLink {
                        SoundSelectView()
                            .navigationTitle("사운드")
                    } label: {
                        HStack {
                            Text("사운드")
                                .foregroundColor(.white)
                            Spacer()
                            Text("전파 탐지기")
                        }
                        .foregroundColor(.gray)
                    }
                    
                    HStack {
                        Text("다시 알림")
                        Toggle(isOn: $isOn) {
                            
                        }
                    }
                    if alarmToEdit != nil {
                        Section {
                            Button {
                                //handleDeletAlarm
                            } label: {
                                HStack(alignment: .center) {
                                    Spacer()
                                    Text("알람 삭제")
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                .onAppear() {
                    if firstAppear, let alarm = alarmToEdit {
                        newAlarm = alarm
                        selectedTime = alarm.mainTime
                        labelText = alarm.label
                        isOn = alarm.reTime
                        firstAppear = false
                    }
                }
                
                
            }
            .toolbar() {
                ToolbarItem {
                    Button {
                        if let alarm = alarmToEdit {
                            handleEditAlarm()
                        } else {
                            handleAppendAlarm()
                        }
                    } label: {
                        Text("저장")
                            .bold()
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
            .navigationTitle(alarmToEdit != nil ? "알람 편집" : "알람 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func handleAppendAlarm() {
        newAlarm.mainTime = selectedTime
        newAlarm.reTime = isOn
        newAlarm.label = labelText.isEmpty ? "알람":labelText
        onAdd?(newAlarm)
        dismiss()
    }
    
    func handleEditAlarm() {
        newAlarm.mainTime = selectedTime
        newAlarm.reTime = isOn
        newAlarm.label = labelText.isEmpty ? "알람":labelText
        onEdit?(newAlarm)
        dismiss()
    }
}

