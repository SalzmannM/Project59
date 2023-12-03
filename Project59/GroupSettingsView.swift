//
//  GroupSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct GroupSettingsView: View {
    @State var groupName:String = ""
    @State var target:Int = 0
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    @State private var arr = ["1","2","3"]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Group Settings")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Groupname", text: $groupName)
                TextField("Target", value: $target, format: .number)
                DatePicker(
                    "Start Date",
                    selection: $startDate,
                    displayedComponents: [.date]
                )
                DatePicker(
                    "End Date",
                    selection: $endDate,
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
                TextField("Drink", text: $groupName)
                TextField("Weight", value: $target, format: .number)
                VStack {
                    List {
                        ForEach(self.arr.indices, id:\.self) {
                            TextField("", text: self.$arr[$0])
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
    }
}

#Preview {
    GroupSettingsView()
}
