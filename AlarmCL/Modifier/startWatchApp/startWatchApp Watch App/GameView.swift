//
//  GameView.swift
//  startWatchApp Watch App
//
//  Created by 주환 on 2023/06/02.
//
import SwiftUI

struct GameView: View {
    @EnvironmentObject var data: SharedData
    @Environment(\.dismiss) var dismiss
    
    @State private var score = 0
    @State private var timeRemaining = 3
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Text("Tap !")
                .font(.system(size: 50))
                .padding()
            
            Text("\(score)")
                .font(.system(size: 50))
            HStack {
                Text("남은 시간 : \(timeRemaining)")
            }
            
        }
        .frame(minWidth: 500,minHeight: 500)
        .background(Color.black)
        .onTapGesture {
            if timeRemaining != 0 {
                score += 1
            }
        }
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .overlay {
            if timeRemaining == 0{
                Button {
                    data.countList.append(score)
                    dismiss()
                } label: {
                    Text("End !")
                }.buttonStyle(.borderedProminent)
            }

        }
    }
    
}


struct GameViewView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
