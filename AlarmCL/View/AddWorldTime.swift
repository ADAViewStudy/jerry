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
    var filteredItems: [[WorldTimes]] {
        if searchText.isEmpty {
            return sortedItems
        } else {
            return sortedItems.map { section in
                section.filter { item in
                    item.city.localizedCaseInsensitiveContains(searchText)
                }
            }.filter { !$0.isEmpty }
        }
    }
    
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
            List {
                ForEach(filteredItems, id: \.self) { section in
                    Section(header: Text(section.first!.city.prefix(1))) {
                        ForEach(section, id:\.self) { item in
                            Button {
                                DataController.shared.addWorldTime(time: item.currentTime, location: item.city, context: managedObjContext)
                                dismiss()
                            } label: {
                                Text(item.city)
                            }
                        }
                    }
                }
            }
            .modifier(VerticalIndex(indexableList: alphabet))
            .listStyle(.plain)
            
        }
        .onAppear() {
            sortedItems = splitIntoSections(wTimes())
        }
        .background()
        
    }
    
    func handleAddWorldTime(time: Date, city: String) {
        DataController.shared.addWorldTime(time: time, location: city, context: managedObjContext)
        dismiss()
    }
}

struct AddWorldTime_Previews: PreviewProvider {
    static var previews: some View {
        AddWorldTime()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}

