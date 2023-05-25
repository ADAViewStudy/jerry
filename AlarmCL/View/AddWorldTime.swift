//
//  addWorldTime.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/25.
//

import SwiftUI

struct AddWorldTime: View {
    
    @State private var searchText = ""
    @State private var searchResults: [String] = []
    
    var body: some View {
        SearchView()
//            .toolbarTitleMenu(content: {
//                Text("도시 선택")
//            })
    }
}


struct AddWorldTime_Previews: PreviewProvider {
    static var previews: some View {
        AddWorldTime()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}
