//
//  GroupSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct GroupSettingsView: View {
    @State var groupname: String = ""
    @State var target: Float = 100
    @State var start: Date = Date.now
    @State var stop: Date = Date.now
    @State var drinkslist:[DrinkSettingsView] = []
    @State var errorMessage: String = ""
    @State var drinkname: String = ""
    @State var weight: Float = 1
    
    
    @State var networking = Networking.shared
    
    @Environment(\.dismiss) var dismiss
   
    
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
        dismiss()
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack {
                    HStack{
                        Text("Group")
                        TextField("Groupname", text: $groupname).background(.white)
                    }
                    
                    HStack{
                        Text("Target")
                        TextField("Target", value: $target, format: .number).background(.white)
                    }.hidden()
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
                    Text("Drink Options")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    HStack{
                        VStack{
                            Text("Drink") .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Drink", text: $drinkname).background(.white)
                        }    .frame(maxWidth: .infinity, alignment: .leading)
                        VStack{
                            Text("Weight") .frame(maxWidth: 70, alignment: .leading)
                            TextField("Weight", value: $weight, format: .number).background(.white)
                                .frame(maxWidth: 70, alignment: .leading)
                        }
                    }
                    
                   
                    HStack{
                        
                       
                        Button("Add Drink") {
                            drinkslist.append(DrinkSettingsView(drinkname: $drinkname.wrappedValue, weight: $weight.wrappedValue))
                        }
                    }
                    VStack {
                        if drinkslist.count > 0{
                            ForEach(drinkslist, id: \.id) { drink in
                                drink
                            }                 .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .leading)
                        }
                    }
   
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Material.regular)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 5)
                .padding()
            }.navigationTitle("Group Settings")
            .toolbar {
                Button("Save", action: saveGroup)
                
            }
        }
    }
}

#Preview {
    GroupSettingsView()
}
