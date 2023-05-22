//
//  AlarmListView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/22.
//

import SwiftUI

struct AlarmListView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)]) var alarms: FetchedResults<Alarm>
    
    var alarm: FetchedResults<Alarm>.Element
    
    @State var isShow = false
    @State var isOn = false
    
//    var onDel: ((Alarm) -> Void)? = nil
    
    var body: some View {
        Button {
            isShow = true
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(meridiemFormatter.string(from: alarm.time!))
                            .font(.system(size: 33))
                            .fixedSize(horizontal: true, vertical: false)
                        ZStack {
                            Text(timeFormatter.string(from: alarm.time!))
                                .font(.system(size: 45))
                                .fixedSize(horizontal: true, vertical: false)
                        }
                    }
                    HStack {
                        Text(alarm.label == "" ?  "알람":alarm.label! + (alarm.freq!.isEmpty ? "":","))
                            .fixedSize(horizontal: true, vertical: false)
                        
                        if alarm.freq != "" {
                            Text(alarm.freq!)
                        }
                        Spacer()
                    }
                }
                .foregroundColor(isOn ? .white : .gray)
                Toggle(isOn: $isOn) {}
                    .padding(.trailing)
                    .onAppear() {
                        isOn = alarm.enable
                    }
                    .onChange(of: isOn) { newValue in
                        DataController.shared.editAlarm(alarm: alarm, time: alarm.time!, label: alarm.label!, freq: alarm.freq!, sound: alarm.sound!, enable: isOn, context: managedObjContext)
                    }
                    .onChange(of: alarm.enable) { newValue in
                        isOn = newValue
                    }
            }
        }
        .sheet(isPresented: $isShow) {
            AddAlarmView(alarm: alarm)
                .environment(\.colorScheme, .dark)
                .accentColor(Color.orange)
        }
    }
}