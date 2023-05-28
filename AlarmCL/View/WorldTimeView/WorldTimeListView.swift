//
//  WorldTimeListView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import SwiftUI

struct WorldTimeListView: View {
    
    var worldtime: FetchedResults<WorldTime>.Element
//    var worldtime: WorldTimes = .init(timeZone: TimeZone(identifier: "Europe/Berlin")!, city: "Berlin")
    @Environment(\.editMode) private var editMode
    
    var body: some View {
        VStack(alignment: .leading,spacing: -15) {
            Text("오늘, -\(2) 시간")
                .font(.system(size: 15))
            
            HStack(alignment: .lastTextBaseline) {
                Text((worldtime.location ?? "error"))
                    .font(.system(size: 25))
                    .fixedSize(horizontal: true, vertical: false)
                Spacer()
                if editMode?.wrappedValue.isEditing == false {
                    Text(meridiemFormatter.string(from: worldtime.time ?? Date()))
                        .font(.system(size: 30))
                        .fixedSize(horizontal: true, vertical: false)
                    Text(timeFormatter.string(from: worldtime.time ?? Date()))
                        .fixedSize(horizontal: true, vertical: false)
                        .font(.system(size: 50))
                        .fontWeight(.light)
                } else {
                    Text(" ")
                        .font(.system(size: 50))
                }
            }
        }
    }
    
}

//struct WorldTimeListView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorldTimeListView()
//            .environment(\.colorScheme, .dark)
//            .accentColor(Color.orange)
//    }
//}
