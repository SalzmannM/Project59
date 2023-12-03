//
//  UserSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct UserSettingsView: View {
    @State var userName:String = ""
    
    @State private var selection = ""
    let groups = ["NiceGuys", "Beerlovers", "Oldboys"]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Settings")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                TextField("Username", text: $userName)
                HStack {
                    Picker("Select a group", selection: $selection) {
                        ForEach(groups, id: \.self) {
                            Text($0)
                        }
                    }
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Label("Edit", systemImage: "pencil")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.red)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
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
    UserSettingsView()
}
