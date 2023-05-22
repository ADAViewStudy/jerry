//
//  File.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct DetailAlarmView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedTime = Date()
    @State private var labelText = ""
    @State var isOn = true
    @State private var firstAppear = true
    @State private var freqency = ""
    
    var alarm: FetchedResults<Alarm>.Element? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    .labelsHidden() // Hides the label
                    .datePickerStyle(WheelDatePickerStyle())
                List {
                    NavigationLink {
                        FreqView(freq: $freqency)
                            .navigationTitle("반복")
                    } label: {
                        HStack {
                            Text("반복")
                                .foregroundColor(.white)
                            Spacer()
                            Text(freqency == "" ? "안함":freqency)
                            
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
                    if alarm != nil {
                        Section {
                            Button {
                                if let alarmToDelete = alarm {
                                    DataController.shared.deleteAlarm(alarm: alarmToDelete, context: managedObjContext)
                                    dismiss()
                                }
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
                    if firstAppear, let alarm = alarm {
                        selectedTime = alarm.time!
                        labelText = alarm.label!
                        isOn = alarm.enable
                        freqency = alarm.freq!
                        firstAppear = false
                    }
                }
                
                
            }
            .toolbar() {
                ToolbarItem {
                    Button {
                        if alarm != nil {
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
            .navigationTitle(alarm != nil ? "알람 편집" : "알람 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func handleAppendAlarm() {
        DataController.shared.addAlarm(time: selectedTime, label: labelText, freq: freqency, sound: "sound", enable: isOn, context: managedObjContext)
        dismiss()
    }
    
    func handleEditAlarm() {
        guard let alarm = alarm else { return }
        DataController.shared.editAlarm(alarm: alarm, time: selectedTime, label: labelText, freq: freqency, sound: "sound", enable: isOn, context: managedObjContext)
        dismiss()
    }
}

