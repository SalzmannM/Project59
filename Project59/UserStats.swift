//
//  UserStats.swift
//  Project59
//
//  Created by Maurice Salzmann on 13.12.23.
//

import SwiftUI

struct UserStats: View {
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    @State var user: String
    @State var group: String
    
    var body: some View {
        VStack {
            Text("User Stats")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(user)
            HStack {
                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle")
                }
                else if let userRanking = networking.userRanking {
                    ForEach(userRanking) { userrank in
                        VStack {
                            Text(userrank.username)
                            Text(userrank.group)
                            Text(userrank.drink)
                            Text(userrank.count, format: .number)
                        }
                    }
                } else {
                    Text("You have not drunken something, please drink!")
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
                try await networking.loadUserStats(group: group, user: user)
            }
            catch {
                errorMessage = error.localizedDescription
            }
        }
        .refreshable {
            do {
                try await networking.loadUserStats(group: group, user: user)
            }
            catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    UserStats(user: "Ichbins", group: "testgroup")
}
