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
            Text("User Statistic")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
            VStack{
                HStack{
                    Text("Group").foregroundColor(.gray)
                    Text(group)
                }
                HStack{
                    Text("User").foregroundColor(.gray)
                    Text(user)
                }
            }
               
            HStack {
                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle")
                }
                else if let userRanking: [ConsumedResponse] = networking.userRanking {
                    VStack{
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
                        
                        ForEach(Array(userRanking.enumerated()), id: \.offset)  { index, entry in
                            
                            HStack{
                                let dateFormatter = ISO8601DateFormatter()
                     
                                
                                Text("Last").foregroundColor(.gray)
                                Text(entry.drink).foregroundColor(.gray)
                                Text(dateFormatter.date(from:entry.time)!, style: .date)
                                Text(dateFormatter.date(from:entry.time)!, style: .time)
                            } .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    
                } else {
                    Text("You have not drunken something, please drink!")
                }
                    
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading )
        .padding()
        .background(Material.regular)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 5)
        .padding()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
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
