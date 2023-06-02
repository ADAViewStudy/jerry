//
//  SecondView.swift
//  startWatchApp Watch App
//
//  Created by 주환 on 2023/06/02.
//

import SwiftUI

struct SecondView: View {
    @State private var isGameShow = false
    @State private var isHistoryShow = false
    var body: some View {
        VStack {
            Text("30초 동안 화면 어디든 최대한 많이 터치 해보세요 !")
                .padding()
            HStack {
                Button("기록 보기") {
                    isHistoryShow = true
                }
                Button("시작 하기") {
                    isGameShow = true
                }
            }
        }.sheet(isPresented: $isGameShow) {
            GameView()
        }
        .sheet(isPresented: $isHistoryShow) {
            HistoryView()
        }
    }
    
}


struct SecondViewView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
