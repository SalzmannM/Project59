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
                    Text("User Settings")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    TextField("Username", text: $userSettings.nickName)
                    HStack {
                        if let errorMessage {
                            Label(errorMessage, systemImage: "exclamationmark.triangle")
                        }
                        else if let groups = networking.groups {
                            Picker("Select a group", selection: $userSettings.groupName) {
                                ForEach(groups) { group in
                                    Text(group.group)
                                }
                            }
                        } else {
                            Text("There is no existing group yet, please create one")
                        }
                        NavigationLink {
                            GroupSettingsView()
                        } label: {
                            Label("Add", systemImage: "person.badge.plus")
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
