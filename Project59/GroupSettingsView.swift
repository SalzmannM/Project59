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
    @State var errorMessage: String?
    @State var drinkname: String = ""
    @State var weight: Float = 1
    
    
    @State var networking = Networking.shared
    
    @Environment(\.dismiss) var dismiss
   
    
    func saveGroup() {
        if groupname != "" {
            Task {
                
                do {
                    try await networking.sendGroup(group: groupname, target: target, start: start, stop: stop)
                    self.errorMessage = nil
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
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                VStack {
                    Text("Drinks")
                        .font(.title2)
                    
                    HStack{
                        VStack{
                            Text("Drink") .frame(maxWidth: .infinity, alignment: .leading)
                            TextField("Drink", text: $drinkname)
                        }    .frame(maxWidth: .infinity, alignment: .leading)
                        VStack{
                            Text("Weight") .frame(maxWidth: 70, alignment: .leading)
                            TextField("Weight", value: $weight, format: .number)
                                .frame(maxWidth: 70, alignment: .leading)
                        }
                    }
                    
                    VStack{
                        
                        Button("Add Drink") {
                            if drinkname != ""
                            {
                                drinkslist.append(DrinkSettingsView(drinkname: $drinkname.wrappedValue, weight: $weight.wrappedValue))
                                drinkname = ""
                            }
                        }
                      
                    }
            
                    VStack {
                        if drinkslist.count > 0{
                            ForEach(drinkslist, id: \.id) { drink in
                                drink
                            }                 .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .leading)
                            Button("Clear Drinks") {
                                drinkslist = []
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
                
                VStack {
                    HStack{
                        Text("Group")
                        TextField("Groupname", text: $groupname)
                    }
                    /*
                    HStack{
                        Text("Target")
                        TextField("Target", value: $target, format: .number).background(.white)
                    }.hidden()
                   
                        DatePicker(
                        "Start Time",
                        selection: $start,
                        displayedComponents: [.date]
                        ).disabled(true)
                    DatePicker(
                        "Stop Time",
                        selection: $stop,
                        displayedComponents: [.date]
                    ).hidden()*/
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
