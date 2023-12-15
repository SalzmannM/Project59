//
//  UserSettingsView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct UserSettingsView: View {
    @Environment(UserSettings.self) private var userSettings
    
    @State var networking = Networking.shared
    @State var errorMessage: String?
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        NavigationStack {
            ScrollView {
                VStack {
                    HStack{
                        Text("Username:").bold()
                        TextField("Username", text: $userSettings.nickName).background(.white)
                    }
                    HStack {
                        HStack{
                            Text("Group:").bold()
                            if let errorMessage {
                                Label(errorMessage, systemImage: "exclamationmark.triangle")
                            }
                            else if let groups = networking.groups {
                                Picker("group", selection: $userSettings.groupName) {
                                    ForEach(groups) { group in
                                        Text(group.group)
                                            .tag(group.group)
                                    }
                                }.frame(maxWidth: .infinity, alignment: .leading)
                            } else {
                                Text("There is no existing group yet, please create one")
                            }
                        }
                            
                      
                    }
                    Spacer(minLength: 50)
                    
                    NavigationLink {
                        GroupSettingsView()
                    } label: {
                        Label("create new group", systemImage: "person.badge.plus")
                            .padding(8)
                            .foregroundStyle(.white)
                            .background(.blue)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Material.regular)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 5)
                .padding()
                .task {
                    do {
                        try await networking.loadGroups()
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
                }
                .refreshable {
                    do {
                        try await networking.loadGroups()
                    }
                    catch {
                        errorMessage = error.localizedDescription
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    UserSettingsView()
        .environment(UserSettings.shared)
}
