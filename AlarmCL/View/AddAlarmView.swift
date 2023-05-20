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
    
    @Binding var alarmArr: [Alarm]
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
                }
            }
            .toolbar() {
                ToolbarItem {
                    Button {
                        handleApendAlarm()
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
            .navigationTitle("알람 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func handleApendAlarm() {
        newAlarm.mainTime = selectedTime
        newAlarm.reTime = isOn
        newAlarm.label = labelText.isEmpty ? "알람":labelText
        alarmArr.append(newAlarm)
//        print(String(alarmArr.endIndex))
        dismiss()
    }
}


//struct AddAlarmView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddAlarmView()
//            .environment(\.colorScheme, .dark)
//            .accentColor(Color.orange)
//    }
//}
