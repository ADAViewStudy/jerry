//
//  ContentView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            WorldTimeView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("세계 시계")
                }.tag(0)
            AlarmView()
                .tabItem {
                    Image(systemName: "alarm.fill")
                    Text("알람")
                }.tag(1)
            StopWatchView()
                .tabItem {
                    Image(systemName: "stopwatch.fill")
                    Text("스톱워치")
                }.tag(2)
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("타이머")
                }.tag(3)
        }
        .onAppear() {
            selection = TimerUserDefaultManager.shared.getSelectionNum()
        }
        .onChange(of: selection) { newValue in
            TimerUserDefaultManager.shared.selectionSave(selectionNum: newValue)
        }
//        .background(Color.black)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
            .accentColor(Color.orange) // here you can set your custom color
    }
}
