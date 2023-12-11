//
//  GroupSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct GroupSettingsView: View {
    @State var groupname: String = ""
    @State var target: Float = 0
    @State var start: Date = Date.now
    @State var stop: Date = Date.now
    @State var drinkslist:[DrinkSettingsView] = []
    @State var errorMessage: String = ""
    @State var drinkname: String = ""
    @State var weight: Float = 0
    
    @State var networking = Networking.shared
    
    
    func saveGroup() {
        Task {
            do {
                try await networking.sendGroup(group: groupname, target: target, start: start, stop: stop)
            }
            catch {
                self.errorMessage = error.localizedDescription
            }
        }
        
        drinkslist.forEach { drinkAdd in
            Task {
                await drinkAdd.saveDrink(group: $groupname.wrappedValue)
            }
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text(errorMessage)
                Text("Group Settings")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Groupname", text: $groupname)
                TextField("Target", value: $target, format: .number)
                DatePicker(
                    "Start Time",
                    selection: $start,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "Stop Time",
                    selection: $stop,
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
                Text("Available Drinks")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                VStack {
                    List(drinkslist, id: \.id) { drink in
                        drink
                    }
                    TextField("Drink", text: $drinkname)
                    TextField("Weight", value: $weight, format: .number)
                    Button("Add") {
                        drinkslist.append(DrinkSettingsView(drinkname: $drinkname.wrappedValue, weight: $weight.wrappedValue))
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
