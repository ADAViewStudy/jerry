//
//  startWatchAppApp.swift
//  startWatchApp Watch App
//
//  Created by 주환 on 2023/06/02.
//

import SwiftUI

@main
struct startWatchApp_Watch_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SharedData())
        }
    }
}
