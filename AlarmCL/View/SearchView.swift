//
//  SearchView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import SwiftUI

struct SearchView: View {
    
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
                    ForEach(array.filter{$0.timeZone.identifier.hasPrefix(searchText) || searchText == ""}, id:\.self) { location in
                        Button(action: {
                            
                        }, label: {
                            Text(location.timeZone.identifier)
                        })
                    }
                } //리스트의 스타일 수정
                .listStyle(PlainListStyle())
                  //화면 터치시 키보드 숨김
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .navigationBarTitle("도시 선택")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


//화면 터치시 키보드 숨김
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
