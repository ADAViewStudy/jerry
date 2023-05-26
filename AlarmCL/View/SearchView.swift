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
    
    let array = wTimes()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    SearchBar(text: $searchText)
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .padding(.trailing)
                    }
                }
                List {
                    ForEach(array.filter{$0.city.hasPrefix(searchText) || searchText == ""}, id:\.self) { location in
                        Button(action: {
                            handleAddWorldTime(time: location.currentTime, city: location.city)
                        }, label: {
                            Text(location.city)
                        })
                    }
                } //리스트의 스타일 수정
                .listStyle(.plain)
            }
            .navigationBarTitle("도시 선택")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    func handleAddWorldTime(time: Date, city: String) {
        DataController.shared.addWorldTime(time: time, location: city, context: managedObjContext)
        dismiss()
    }
}

struct AddWorldTime_Previews: PreviewProvider {
    static var previews: some View {
        AddWorldTime()
    }
}

