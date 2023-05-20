//
//  AlarmView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct AlarmView: View {
    
    @State var alarmArr: [Alarm] = [
        Alarm(mainTime: Date(), cycle: [], label: "알람", sound: "4", reTime: false),
        Alarm(mainTime: Date(), cycle: ["월","일"], label: "알람", sound: "44", reTime: false)
    ]
    @State var isShow: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    sleepSection()
                        .listRowBackground(Color.black)
                } header: {
                    Text("🛏️ 수면 | 기상")
                        .padding()
                        .font(.title2.bold())
                }
                Section {
                    ForEach(alarmArr.indices, id: \.self) { index in
                        AlarmListView(alarm: $alarmArr[index])
                            .listRowBackground(Color.black)
                    }
                } header: {
                    Text("기타")
                        .font(.title2.bold())
                }

            }
            .listStyle(.grouped)
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
                AddAlarmView(alarmArr: $alarmArr)
                    .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
                    .accentColor(Color.orange) // here you can set your custom color
                
            }
        }
    }
    
    func sleepSection() -> some View {
        return VStack {
            HStack {
                Text("알람 없음")
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
                Button {
                    // handleSleepAlarm
                } label: {
                    Text("설정")
                        .frame(width: 42)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.primary)
                        )
                }
                
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
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                        Text(alarm.meridiem)
                            .font(.system(size: 33))
                    ZStack {
                        Text(alarm.time)
                            .font(.system(size: 45))
                            .fixedSize(horizontal: true, vertical: false)
                    }
                }
                HStack {
                    Text(alarm.label + (alarm.cycle.isEmpty ? "":","))
                    
                    ForEach(alarm.cycle.indices, id: \.self) { index in
                        if !alarm.cycle.isEmpty {
                            Text(alarm.cycle[index])
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
}
