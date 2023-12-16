//
//  ConsumeDrinkView.swift
//  Project59
//
//  Created by Maurice Salzmann on 16.12.23.
//

import SwiftUI

struct ConsumeDrinkView: View {
    @Environment(UserSettings.self) private var userSettings
    
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    @State var drinkname: String
    
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
    
    func getDrinkImage() -> String {
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


            VStack {
            Button {
                consumeDrink(drink: drinkname)
            } label: {
                Image(getDrinkImage())
                    .resizable()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    //.shadow(radius: 10)
            }
            Text(drinkname)
                .font(.title2)
        }
        .onTapGesture {
            
        }
    }
}

#Preview {
    ConsumeDrinkView(drinkname: "Beer")
        .environment(UserSettings.shared)
}
