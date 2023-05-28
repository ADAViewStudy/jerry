//
//  SearchView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import SwiftUI

struct AddWorldTime: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State var sortedItems: [[WorldTimes]] = []
    @State private var searchText = ""
    @State var filteredItems: [[WorldTimes]] = []
    
    var body: some View {
        VStack {
            VStack {
                Text("도시 선택")
                    .font(.caption)
                    .padding(.top)
                HStack {
                    SearchBar(text: $searchText)
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .padding(.trailing)
                    }
                }
            }
            if !filteredItems.isEmpty {
                WorldTimeTableView(worldtimes: filteredItems, didSelectRow: {item in
                    handleAddWorldTime(diff: item.diffTime,city: item.city, identifier: item.identifier)
                })
                    .id(UUID())
            } else {
                WorldTimeTableView(worldtimes: sortedItems, didSelectRow: {item in
                    handleAddWorldTime(diff: item.diffTime, city: item.city, identifier: item.identifier)
                })
                    .id(UUID())
            }
            
        }
        .onAppear() {
            sortedItems = splitIntoSections(wTimes())
        }
        .onChange(of: searchText, perform: { newValue in
            filterItems()
        })
        .background()
        
    }
    
    func handleAddWorldTime(diff: String,city: String, identifier: String) {
        DataController.shared.addWorldTime(diff: diff,location: city, identifier: identifier, context: managedObjContext)
        dismiss()
    }
    
    func filterItems() {
        if searchText.isEmpty {
            filteredItems = sortedItems
        } else {
            filteredItems = sortedItems.map { section in
                section.filter { item in
                    item.city.localizedCaseInsensitiveContains(searchText)
                }
            }.filter { !$0.isEmpty }
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


