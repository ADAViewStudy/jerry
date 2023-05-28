//
//  SoundSelectView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/20.
//

import SwiftUI

struct SoundSelectView: View {
    
    var sounds = ["sound1", "sound2", "sound3", "sound4", "sound5", "sound6", "sound7"]
    @Binding var sound: String
    @State private var selectedRow: Int?
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        NavigationLink {
                            Text("준비중")
                        } label: {
                            HStack {
                                Text("진동")
                                Spacer()
                                Text("기본 설정")
                                    .foregroundColor(.gray)
                            }
                        }

                    }
                }
                Section {
                    NavigationLink(destination: Text("준비중이야")) {
                        HStack {
                            Spacer().frame(width: 30)
                            Text("노래 선택")
                        }
                        
                    }
                } header: {
                    Text("노래")
                }

                Section {
                    ForEach(sounds.indices, id: \.self) { index in
                        Button {
                            selectedRow = index
                            sound = sounds[index]
                        } label: {
                            HStack{
                                if index == selectedRow {
                                    Image(systemName: "checkmark").frame(width: 22)
                                } else {
                                    Spacer().frame(width: 30)
                                }
                                Text(sounds[index])
                                    .foregroundColor(.white)
                            }
                        }
                    }
                } header: {
                    Text("벨소리")
                }
                Section {
                    HStack {
                        Spacer().frame(width: 30)
                        Text("없음")
                    }
                }
            }
        }
    }
    
}




//struct SoundSelectView_Previews: PreviewProvider {
//    static var previews: some View {
//        SoundSelectView()
//            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
//            .accentColor(Color.orange) // here you can set your custom color
//    }
//}
