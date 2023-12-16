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
    
    
    func consumeDrink(drink: String) {
        Task {
            do {
                try await networking.sendConsumption(
                        username: userSettings.nickName,
                        group: userSettings.groupName,
                        drink: drink
                    )
            }
            catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        ScrollView {
            VStack {
                Text("ConsumeView")
                Text(userSettings.nickName)
                
                if let errorMessage {
                    Label(errorMessage, systemImage: "exclamationmark.triangle")
                }
                else if let drinks = networking.drinks {
                    ForEach(drinks) { drink in
                        HStack {
                            Text(drink.drink)
                            Button("Add") {
                                consumeDrink(drink: drink.drink)
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
        }
    }
}

#Preview {
    ConsumeView()
        .environment(UserSettings.shared)
}
