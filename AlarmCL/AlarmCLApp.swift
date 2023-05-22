//
//  AlarmCLApp.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

@main
struct AlarmCLApp: App {
    @StateObject private var dataController = DataController.shared
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
                .accentColor(Color.orange) // here you can set your custom color
        }
    }
}
