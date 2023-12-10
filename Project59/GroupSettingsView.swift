//
//  GroupSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct GroupSettingsView: View {
    @State var group:Groups
    @State var drinks:[Drinks]
    @State var errorMessage: String?
    
    @State var networking = Networking.shared
    
    func saveGroup() async {
        await saveNewGroup()
        await saveDrinks()
    }
    
    func saveNewGroup() async {
        do {
            try await networking.sendGroup(group)
        }
        catch {
            errorMessage = error.localizedDescription
        }
        print("now it should be saved")
    }
    
    func saveDrinks() async {
        ForEach(drinks) { drink in
            do {
                try await networking.sendDrink(drink)
            }
            catch {
                errorMessage = error.localizedDescription
            }
        }
        print("now it should be saved")
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Group Settings")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Groupname", text: $group.group)
                TextField("Target", value: $group.target, format: .number)
                DatePicker(
                    "Start Time",
                    selection: $group.starttime,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "Stop Time",
                    selection: $group.stoptime,
                    displayedComponents: [.date]
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Material.regular)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding()
            
            VStack {
                Text("Drink Counter")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                VStack {
                    List {
                        ForEach($drinks) { drink in
                            TextField("Drink", text: drink.drink)
                            TextField("Weight", value: drink.weight, format: .number)
                        }
                    }
                }
                .frame(minWidth: 150, maxWidth: .infinity, minHeight: 300, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Material.regular)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .padding()
        }
        .toolbar {
            Button("Save", action: saveGroup)
        }
    }
}

#Preview {
    GroupSettingsView()
}
