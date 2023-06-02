//
//  ContentView.swift
//  startWatchApp Watch App
//
//  Created by 주환 on 2023/06/02.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("많은 터치를 해보세요 !")
                    .padding(.top,70)
                Spacer()
                HStack {
                    Spacer().frame(width: 100)
                    NavigationLink {
                        SecondView()
                    } label: {
                        Text("Next >")
                    }.buttonStyle(.plain)

                }
            }
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
