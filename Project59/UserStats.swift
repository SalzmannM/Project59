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
    
    let user: String
    let group: String
    
    let colors = [
        Color.green,
        Color.red,
        Color.yellow,
        Color.cyan,
        Color.blue,
        Color.purple,
        Color.orange,
        Color.brown,
        Color.pink,
        Color.black
    ]
    
    var body: some View {
        NavigationStack {
           
            VStack{
                HStack{
                    Text("Group").foregroundColor(.gray)
                    Text(group)
                }.frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text("User").foregroundColor(.gray)
                    Text(user)
                }.frame(maxWidth: .infinity, alignment: .topLeading)
            }.padding()
            
            HStack {
                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle")
                }
                else if let userRanking: [ConsumedResponse] = networking.userRanking {
                    
                    if userRanking.isEmpty{
                        Text("No Drinks recorded").frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    VStack{
                        Chart {
                            ForEach(Array(userRanking.enumerated()), id: \.offset) { index, userrank in
                                SectorMark(angle: .value(userrank.drink, userrank.count),
                                           
                                           innerRadius: .ratio(0.25),
                                           angularInset: 4)
                                .foregroundStyle(colors[index])
                                .cornerRadius(5)
                                .annotation(position: .overlay) {
                                    Text("\(userrank.drink): \(userrank.count)")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                }
                            }
                        }.frame(minWidth: 200,  maxWidth: .infinity, minHeight: 200, alignment: .topLeading)
                        Spacer()
                        Text("Most recent").font(.title2).foregroundColor(.gray).frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        ForEach(Array(userRanking.enumerated()), id: \.offset)  { index, entry in
                            
                            HStack{
                                let dateFormatter = ISO8601DateFormatter()
                                
                                
                                HStack{
                                    Text(entry.drink).foregroundColor(.black)
                                }.frame(alignment: .leading)
                                
                                HStack{
                                    Text(dateFormatter.date(from:entry.time)!, style: .date)
                                    Text(dateFormatter.date(from:entry.time)!, style: .time)
                                }.frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        Spacer()
                    }.frame(maxHeight: .infinity, alignment: .bottom)
                    
                    
                } else {
                    Text("You have not drunken something, please drink!")
                }
                
            }.navigationTitle("User Metrics")
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading )
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    //   .shadow(color: .black.opacity(0.3), radius: 5)
        .padding()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
            .task {
                do {
                    try await networking.loadUserStats(group: group, user: user)
                    errorMessage = nil
                }
                catch {
                    errorMessage = error.localizedDescription
                }
            }
            .refreshable {
                do {
                    try await networking.loadUserStats(group: group, user: user)
                    errorMessage = nil
                }
                catch {
                    errorMessage = error.localizedDescription
                }
            }
    }}
}

#Preview {
    UserStats(user: "testuser", group: "testgroup")
}
