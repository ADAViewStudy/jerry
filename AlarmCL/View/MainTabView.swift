//
//  ContentView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            WorldTimeView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("세계 시계")
                }
            AlarmView()
                .tabItem {
                    Image(systemName: "alarm.fill")
                    Text("알람")
                }
            StopWatchView()
                .tabItem {
                    Image(systemName: "stopwatch.fill")
                    Text("스톱워치")
                }
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("타이머")
                }
        }
        .background(Color.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
            .accentColor(Color.orange) // here you can set your custom color
    }
}
