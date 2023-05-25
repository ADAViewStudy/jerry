//
//  WorldTimeView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct WorldTimeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)]) var alarms: FetchedResults<Alarm>
    
    @State private var isShow = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(alarms) { alarm in
                    AlarmListView(alarm: alarm)
                }
//                .onDelete(perform: <#T##Optional<(IndexSet) -> Void>##Optional<(IndexSet) -> Void>##(IndexSet) -> Void#>)
//                .onMove(perform: <#T##Optional<(IndexSet, Int) -> Void>##Optional<(IndexSet, Int) -> Void>##(IndexSet, Int) -> Void#>)
            }
            .navigationTitle("세계 시계")
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
        }
        .sheet(isPresented: $isShow) {
            AddWorldTime()
                .environment(\.colorScheme, .dark)
                .accentColor(Color.orange)
        }
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}
