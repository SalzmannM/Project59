//
//  UserStats.swift
//  Project59
//
//  Created by Maurice Salzmann on 13.12.23.
//

import SwiftUI
import Charts

struct UserStats: View {
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    @State var user: String
    @State var group: String
    
    let colors = [
        Color.green,
        Color.cyan,
        Color.blue,
        Color.purple,
        Color.red,
        Color.orange,
        Color.yellow,
        Color.brown,
        Color.pink,
        Color.black
    ]
    
    var body: some View {
        VStack {
            Text("User Stats")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Text(group)
            Text(user)
            HStack {
                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle")
                }
                else if let userRanking = networking.userRanking {
                    Chart {
                        ForEach(Array(userRanking.enumerated()), id: \.offset) { index, userrank in
                            SectorMark(angle: .value(userrank.drink, userrank.count),
                                       innerRadius: .ratio(0.35),
                                       angularInset: 2)
                            .foregroundStyle(colors[index])
                            .cornerRadius(5)
                            .annotation(position: .overlay) {
                                Text("\(userrank.drink): \(userrank.count)")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
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
