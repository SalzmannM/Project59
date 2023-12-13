//
//  RankingListView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct RankingListView: View {
    @Environment(UserSettings.self) private var userSettings
    
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        NavigationStack {
            ScrollView {
                VStack {
                    Text("RankingListView")
                    Text(userSettings.groupName)
                    
                    if let errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle")
                    }
                    else if let ranking = networking.ranking {
                        ForEach(ranking) { userrank in
                            HStack {
                                HStack {
                                    NavigationLink(userrank.username) {
                                        UserStats(user: userrank.username, group: userrank.group)
                                    }
                                    Text(userrank.group)
                                    Text(userrank.drink)
                                    Text(userrank.count, format: .number)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Material.regular)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 5)
                .padding()
                .task {
                    do {
                        try await networking.loadRanking(userSettings.groupName)
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
                }
                .refreshable {
                    do {
                        try await networking.loadRanking(userSettings.groupName)
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

#Preview {
    RankingListView()
        .environment(UserSettings.shared)
}
