//
//  WorldTimeView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI
import CoreData

struct WorldTimeView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \WorldTime.order, ascending: true)]) var worldtimes: FetchedResults<WorldTime>
    
    @State private var isShow = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(worldtimes) { time in
                    WorldTimeListView(worldtime: time)
                }
                .onDelete { index in
                    DataController.shared.deleteWorldTimeIndex(worldTime: worldtimes, offsets: index, context: managedObjContext)
                }
                .onMove { index, num in
                    DataController.shared.moveWorldTime(worldTime: worldtimes, from: index, to: num, context: managedObjContext)
                }
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
            .listStyle(.plain)
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
