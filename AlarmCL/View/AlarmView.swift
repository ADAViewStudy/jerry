//
//  AlarmView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct AlarmView: View {
    
    @State var alarmArr: [Alarm] = [
        Alarm(mainTime: Date(), cycle: "2", label: "3", sound: "4", reTime: false),
        Alarm(mainTime: Date(), cycle: "22", label: "32", sound: "42", reTime: false),
        Alarm(mainTime: Date(), cycle: "23", label: "33", sound: "43", reTime: false),
        Alarm(mainTime: Date(), cycle: "24", label: "34", sound: "44", reTime: false)
    ]
    @State var isShowAddView: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                sleepSection()
                VStack {
                    HStack {
                        Text("기타")
                            .font(.title2.bold())
                            .padding()
                        Spacer()
                    }
                    Divider()
                }
                ForEach(alarmArr.indices) { index in
                    AlarmListView(alarmArr: $alarmArr[index])
                }
            }
            .navigationTitle("알람")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar() {
                ToolbarItem {
                    Button {
                        isShowAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //handle Plus
                    } label: {
                        Text("편집")
                    }
                }
            }
            .sheet(isPresented: $isShowAddView) {
                AddAlarmView()
                    .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
                    .accentColor(Color.orange) // here you can set your custom color
                
            }
        }
    }
    
    func sleepSection() -> some View {
        return VStack {
            HStack {
                Text("🛏️ 수면 | 기상")
                    .padding()
                    .font(.title2.bold())
                Spacer()
            }
                .bold()
            Divider()
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
            Divider()
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
    
    @Binding var alarmArr: Alarm
    @State var isOn: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack() {
                    VStack{
                        Text(alarmArr.meridiem)
                            .font(.system(size: 33))
                    }
                    VStack{
                        Text(alarmArr.time)
                            .font(.system(size: 45))
                        Spacer()
                    }
                }
                HStack{
                    Text("알람")
                    Spacer()
                }
            }.padding(.leading)
            .foregroundColor(isOn ? .white : .gray)
            Divider()
            Toggle(isOn: $isOn) {}
                .padding(.trailing)
        }
    }
}
