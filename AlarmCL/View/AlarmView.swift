//
//  AlarmView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct AlarmView: View {
    
    @State var alarmArr: [Alarm] = [
//                Alarm(mainTime: Date(), cycle: [], label: "알람", sound: "4", reTime: false),
                Alarm(mainTime: Date(), cycle: ["월","일"], label: "람람", sound: "44", reTime: false)
    ]
    @State var isShow: Bool = false
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    sleepSection()
                        .listRowBackground(Color.black)
                        .padding([.top,.bottom])
                } header: {
                    HStack {
                        Image(systemName: "bed.double.fill")
                        Text("수면 | 기상")
                            .font(.title2)
                    }
                    .bold()
                    .foregroundColor(.white)
                }
                
                Section {
                    ForEach(alarmArr.indices, id: \.self) { index in
                        AlarmListView(alarm: $alarmArr[index])
                    }
                    .onDelete { index in
                        alarmArr.remove(atOffsets: index)
                    }
                } header: {
                    if !alarmArr.isEmpty {
                        Text("기타")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                }
            }
//            .onAppear() {
//                alarmArr.sort { $0.mainTime < $1.mainTime }
//                print("DEBUG: Sorted !!!!!")
//
//            }
            .onChange(of: alarmArr, perform: { newValue in
                alarmArr.sort { $0.mainTime < $1.mainTime }
            })
            .listStyle(.plain)
            .navigationTitle("알람")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar() {
                ToolbarItem {
                    Button {
                        isShow = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $isShow) {
                AddAlarmView() { new in
                    let alarm = Alarm(mainTime: new.mainTime, cycle: new.cycle, label: new.label, sound: new.sound, reTime: new.reTime)
                    alarmArr.append(alarm)
                }
                .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
                .accentColor(Color.orange) // here you can set your custom color
            }
        }
    }
    
    func sleepSection() -> some View {
        return HStack {
            Text("알람 없음")
                .foregroundColor(.gray)
            Spacer()
            Button {
                // handleSleepAlarm
            } label: {
                Text("설정")
                    .bold()
                    .foregroundColor(.orange)
                    .frame(width: 45,height: 23)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.secondary)
                    )
            }
            
        }
    }
    
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
            .accentColor(Color.orange) // here you can set your custom color
    }
}

struct AlarmListView: View {
    
    @Binding var alarm: Alarm
    @State var isShow = false
    var body: some View {
        Button {
            isShow = true
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(alarm.meridiem)
                            .font(.system(size: 33))
                            .fixedSize(horizontal: true, vertical: false)
                        ZStack {
                            Text(alarm.time)
                                .font(.system(size: 45))
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                    HStack {
                        Text(alarm.label + (alarm.cycle.isEmpty ? "":","))
                            .fixedSize(horizontal: true, vertical: false)
                        
                        ForEach(alarm.cycle.indices, id: \.self) { index in
                            if !alarm.cycle.isEmpty {
                                Text(alarm.cycle[index])
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                        }
                        Spacer()
                    }
                }
                .foregroundColor(alarm.reTime ? .white : .gray)
                Toggle(isOn: $alarm.reTime) {}
                    .padding(.trailing)
            }
        }
        .sheet(isPresented: $isShow) {
            AddAlarmView(onEdit: { new in
                let editAlarm = Alarm(mainTime: new.mainTime, cycle: new.cycle, label: new.label, sound: new.sound, reTime: new.reTime)
                alarm = editAlarm
                
            }, alarmToEdit: alarm)
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
        }
    }
}
