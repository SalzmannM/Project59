//
//  Project59App.swift
//  Project59
//
//  Created by Maurice Salzmann on 13.11.23.
//

import SwiftUI
import Vapor


@main
struct Project59App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}



 
let app = try Application(.detect())
defer { app.shutdown() }

app.get("hello") { req in
    return "Hello, world."
}

try app.run()
