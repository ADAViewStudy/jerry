//
//  WorldTimeListView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import SwiftUI

struct WorldTimeListView: View {
    
    var worldtime: FetchedResults<WorldTime>.Element
    @Environment(\.editMode) private var editMode
    
    @State private var currentTime = Date()
    @State private var selectedTimeZoneIdentifier = ""
    @State private var currentDay = ""
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .leading,spacing: -15) {
            Text("\(currentDay), \(worldtime.diffTime ?? "error") 시간")
                .font(.system(size: 15))
            
            HStack(alignment: .lastTextBaseline) {
                Text((worldtime.location ?? "error"))
                    .font(.system(size: 25))
                    .fixedSize(horizontal: true, vertical: false)
                Spacer()
                if editMode?.wrappedValue.isEditing == false {
                    if let identifier = worldtime.identifier {
                        Text(worldtimeFormatter(for: identifier, currentTime: currentTime))
                            .font(.system(size: 30))
                            .fixedSize(horizontal: true, vertical: false)
                        Text(worldmeridiemFormatter(for: identifier, currentTime: currentTime))
                            .fixedSize(horizontal: true, vertical: false)
                            .font(.system(size: 50))
                            .fontWeight(.light)
                    }
                } else {
                    Text(" ")
                        .font(.system(size: 50))
                }
                
            }.onReceive(timer) { _ in
                currentTime = Date()
            }
            .onAppear() {
                guard let identifier = worldtime.identifier else { return }
                currentDay = compareDates(currentDate: currentTime, identifier: identifier)
            }
        }
    }
    
}

