//
//  routes.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Foundation


func routes(_ app: Application) throws {
    app.get { req async in
        "It works."
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    app.get("reset-data") { req async throws -> HTTPStatus in
        guard Environment.get("RESET_KEY") == req.headers.first(name: "RESET_KEY") else {
            req.logger.error("Environment.RESET_KEY: \(Environment.get("RESET_KEY") ?? "")")
            req.logger.error("Headers.RESET_KEY: \(req.headers.first(name: "RESET_KEY") ?? "")")
            throw Abort(.unauthorized)
        }
        try await Drinks.query(on: req.db).delete()
        try await Groups.query(on: req.db).delete()
        try await Consumed.query(on: req.db).delete()

        return .ok
    }

    try app.register(collection: Controller())

}
