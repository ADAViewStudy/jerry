//
//  AlarmView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI
import CoreData

struct AlarmView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)]) var alarms: FetchedResults<Alarm>
    
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
                    ForEach(alarms) { alarm in
                        AlarmListView(alarm: alarm)
                    }
                    .onDelete(perform: deleteAlarm)
                } header: {
                    if !alarms.isEmpty {
                        Text("기타")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                    }
                }
            }
            //            .onChange(of: alarmArr, perform: { newValue in
            //                alarmArr.sort { $0.mainTime < $1.mainTime }
            //            })
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
                AddAlarmView()
                    .environment(\.colorScheme, .dark)
                    .accentColor(Color.orange)
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
    private func deleteAlarm(offsets: IndexSet) {
        withAnimation {
            offsets.map { alarms[$0] }.forEach(managedObjContext.delete)
            DataController.shared.save(context: managedObjContext)
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


