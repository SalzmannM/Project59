//
//  RankingListView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct RankingListView: View {
    @Environment(UserSettings.self) private var userSettings
    
    var body: some View {
        Text("RankingListView")
        Text(userSettings.groupName)
    }
}

#Preview {
    RankingListView()
        .environment(UserSettings.shared)
}
