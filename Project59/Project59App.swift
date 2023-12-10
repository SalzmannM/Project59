//
//  Project59App.swift
//  Project59
//
//  Created by Maurice Salzmann on 13.11.23.
//

import SwiftUI


@main
struct Project59App: App {
    @State private var userSettings: UserSettings = UserSettings.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userSettings)
        }
    }
}
