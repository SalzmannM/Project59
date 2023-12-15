//
//  RankingListView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct RankEntryView: View {
    var entry: Rank_Entry


    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            NavigationLink(entry.user) {
                UserStats(user: entry.user, group: entry.group)
            }
                .foregroundColor(.primary)
                .font(.headline)
            HStack(spacing: 3) {
                Label(String(entry.score), systemImage: "person").bold().foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            .foregroundColor(.secondary)
            
            .font(.subheadline)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct RankingListView: View {
    @Environment(UserSettings.self) private var userSettings
    
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        NavigationStack {
            ScrollView {
                VStack (){
                    Text(userSettings.groupName).font(.title2).bold().foregroundColor(.gray) .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    Spacer()
                        
                    
                    if let errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle")
                    }
                    else if let ranking = networking.ranking {
                        if ranking.isEmpty{
                            Text("No Entries recorded").frame(maxWidth: .infinity, alignment: .center)
                        }
                        NavigationView{
                            List {
                                ForEach(ranking) { entry in RankEntryView(entry: entry)}
                               
                            }.listStyle(.plain)
                        }
                    }
                    
                }
               
                .padding()
                //.background(Material.regular)
                //.clipShape(RoundedRectangle(cornerRadius: 30))
                //.shadow(color: .black.opacity(0.3), radius: 5)
                //.padding()
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
            }.navigationTitle("Scores")
        }
    }
}

#Preview {
    RankingListView()
        .environment(UserSettings.shared)
}
