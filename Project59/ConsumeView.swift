//
//  ConsumeView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct ConsumeView: View {
    @Environment(UserSettings.self) private var userSettings
    
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    var body: some View {
        @Bindable var userSettings = userSettings
        let adaptiveColumn = [
            GridItem(.flexible(minimum: 100, maximum: 300)),
            GridItem(.flexible(minimum: 100, maximum: 300)),
            GridItem(.flexible(minimum: 100, maximum: 300))
           
        ]
        
        NavigationStack {
            /*
            VStack{
                HStack{
                    Text("Group").foregroundColor(.gray)
                    Text(userSettings.groupName)
                }.frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text("User").foregroundColor(.gray)
                    Text(userSettings.nickName)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.padding().hidden() */
            if let errorMessage {
                Label(errorMessage, systemImage: "exclamationmark.triangle")
            }
            if userSettings.nickName == "" || userSettings.groupName == ""
            {
                Label("You have not set a username and group in the Settings Tab", systemImage: "exclamationmark.triangle").padding()
         
            }
                
            ScrollView {
                LazyVGrid(columns: adaptiveColumn, spacing: 20)
                {
               
                     if let drinks = networking.drinks {
                        ForEach(drinks, id: \.id) { drink in
                            ConsumeDrinkView(drinkname: drink.drink).frame(minHeight: 100, maxHeight:170, alignment: .top)
                           
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding()
            //.background(Material.regular)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding()
            .task {
                do {
                    try await networking.loadDrinks(userSettings.groupName)
                    errorMessage = nil
                }
                catch {
                    errorMessage = error.localizedDescription
                }
            }
            .refreshable {
                do {
                    try await networking.loadDrinks(userSettings.groupName)
                    errorMessage = nil
                }
                catch {
                    errorMessage = error.localizedDescription
                }
            }
            .navigationTitle("Consume")
        }
    }
}

#Preview {
    ConsumeView()
        .environment(UserSettings.shared)
}
