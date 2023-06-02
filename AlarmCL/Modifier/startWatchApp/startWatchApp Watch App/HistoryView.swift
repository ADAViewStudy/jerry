//
//  HistoryVIew.swift
//  startWatchApp Watch App
//
//  Created by 주환 on 2023/06/02.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var data: SharedData
    
    var body: some View {
        VStack {
            List {
                ForEach(data.countList
                        , id: \.self) { index in
                    Text("my Count = \(index)")
                        .foregroundColor(data.countList.max() == index ? .green:.white)
                }
            }
        }
    }
    
}


struct HistoryViewView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
