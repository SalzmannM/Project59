//
//  ContentView.swift
//  Project59
//
//  Created by Maurice Salzmann on 13.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ConsumeView()
                .tabItem {
                    Label("Consume", systemImage: "wineglass")
                }
            RankingListView()
                .tabItem {
                    Label("Ranking", systemImage: "crown")
                }
            UserSettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(UserSettings.shared)
}
