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
    
    func getDrinkImage(drinkname: String) -> String {
        var drinkimage = "Drink"
        if drinkname.lowercased().contains("cocktail") {
            drinkimage = "Cocktail"
        } else if drinkname.lowercased().contains("longdrink") {
            drinkimage = "Longdrink"
        } else if drinkname.lowercased().contains("shot") || drinkname.lowercased().contains("schnaps") {
            drinkimage = "Shot"
        } else if drinkname.lowercased().contains("red") && drinkname.lowercased().contains("wine") {
            drinkimage = "Redwine"
        } else if drinkname.lowercased().contains("wine") {
            drinkimage = "Whitewine"
        } else if drinkname.lowercased().contains("mug") || drinkname.lowercased().contains("mass") {
            drinkimage = "Mug"
        } else if drinkname.lowercased().contains("pilsner") || drinkname.lowercased().contains("stange") {
            drinkimage = "Pilsner"
        } else if drinkname.lowercased().contains("stein") || drinkname.lowercased().contains("humpen") {
            drinkimage = "Stein"
        } else if drinkname.lowercased().contains("tulip") {
            drinkimage = "Tulip"
        } else if drinkname.lowercased().contains("beer") {
            drinkimage = "Chalice"
        }
        return drinkimage
    }
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        NavigationStack {
            VStack{
                HStack{
                    Text("Group").foregroundColor(.gray)
                    Text(userSettings.groupName)
                }.frame(maxWidth: .infinity, alignment: .leading)
                HStack{
                    Text("User").foregroundColor(.gray)
                    Text(userSettings.nickName)
                }.frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
            
            ScrollView {
                VStack(alignment: .leading) {
                    if let errorMessage {
                        Label(errorMessage, systemImage: "exclamationmark.triangle")
                    }
                    else if let drinks = networking.drinks {
                        ForEach(drinks) { drink in
                            HStack {
                                Button {
                                    consumeDrink(drink: drink.drink)
                                } label: {
                                    Image(getDrinkImage(drinkname: drink.drink))
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .clipShape(Circle())
                                        .shadow(radius: 10)
                                }
                                Text(drink.drink)
                                    .font(.title2)
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
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
                }
                .refreshable {
                    do {
                        try await networking.loadDrinks(userSettings.groupName)
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
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
