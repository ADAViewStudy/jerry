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
        VStack {
            SearchBar(searchText: $searchText)
            
            List(searchResults, id: \.self) { result in
                Text(result)
            }
        }
        .background(Color.black)
        .toolbarTitleMenu(content: {
            Text("도시 선택")
        })
        .onChange(of: searchText) { newSearchText in
            // Perform search logic here to update searchResults
            // For simplicity, we'll use a simple string filtering example
            searchResults = ["Apple", "Banana", "Orange"].filter { fruit in
                return fruit.localizedCaseInsensitiveContains(newSearchText)
            }
        }

    }
}


struct AddWorldTime_Previews: PreviewProvider {
    static var previews: some View {
        AddWorldTime()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}
