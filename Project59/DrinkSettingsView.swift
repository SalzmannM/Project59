//
//  DrinkSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 11.12.23.
//

import SwiftUI

struct DrinkSettingsView: View {
    let id: UUID = UUID()
    @State var networking = Networking.shared
    
    @State var errorMessage: String?
    
    let drinkname: String
    let weight: Float
    
    var body: some View {
        HStack {
            Text(drinkname)
            Text(String(format: "%.2f", weight))
        }
    }
    
    func saveDrink(group: String) async {
        do {
            try await networking.sendDrink(drinkname, weight: weight, group: group)
            errorMessage=nil
        
        }
        catch {
            errorMessage = error.localizedDescription
        }
    }
}

#Preview {
    DrinkSettingsView(drinkname: "Bier", weight: 1)
}
