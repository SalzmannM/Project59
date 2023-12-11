//
//  ConsumeView.swift
//  Project59
//
//  Created by Maurice Salzmann on 20.11.23.
//

import SwiftUI

struct ConsumeView: View {
    @Environment(UserSettings.self) private var userSettings
    
    var body: some View {
        @Bindable var userSettings = userSettings
        
        Text("ConsumeView")
        Text(userSettings.nickName)
    }
}

#Preview {
    ConsumeView()
        .environment(UserSettings.shared)
}
