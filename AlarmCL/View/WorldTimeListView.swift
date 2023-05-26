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
    
    var body: some View {
        VStack(alignment: .leading,spacing: -15) {
            Text("오늘, - \(2) 시간")
                .font(.system(size: 15))
            
            HStack(alignment: .lastTextBaseline) {
                Text(worldtime.location!)
                    .font(.system(size: 30))
                Spacer()
                Text(meridiemFormatter.string(from: worldtime.time!))
                    .font(.system(size: 30))
                Text(timeFormatter.string(from: worldtime.time!))
                    .font(.system(size: 50))
                    .fontWeight(.light)
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
