//
//  AlarmListView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/22.
//

import SwiftUI

struct AlarmListView: View {
    
    @Environment(\.editMode) private var editMode
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
                                .font(.system(size: 50))
                                .fixedSize(horizontal: true, vertical: false)
                                .fontWeight(.light)
                        }
                    }
                    HStack {
                        Text(alarm.label == "" ? "알람": alarm.label!)
//                            .fixedSize(horizontal: true, vertical: false)
                        + Text((alarm.freq!.isEmpty ? "":","))
                        
                        if alarm.freq != "" {
                            Text(alarm.freq!)
                        }
                        Spacer()
                    }
                }
                .onAppear() {
                    isOn = alarm.enable
                }
                .onChange(of: isOn) { newValue in
                    DataController.shared.editAlarm(alarm: alarm, time: alarm.time!, label: alarm.label!, freq: alarm.freq!, sound: alarm.sound!, enable: isOn, reAlarm: alarm.reAlarm, context: managedObjContext)
                }
                .onChange(of: alarm.enable) { newValue in
                    isOn = newValue
                }
                .foregroundColor(isOn ? .white : .gray)
                if editMode?.wrappedValue.isEditing == false {
                    Toggle(isOn: $isOn) {}
                        .padding(.trailing)
                } else {
                    Image(systemName: "chevron.right")
                }
            }
        }
        .sheet(isPresented: $isShow) {
            DetailAlarmView(alarm: alarm)
                .environment(\.colorScheme, .dark)
                .accentColor(Color.orange)
        }
    }
}
