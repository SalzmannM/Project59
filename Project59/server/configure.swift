//
//  configure.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import NIOSSL
import Fluent
import FluentPostgresDriver
#if canImport(FluentSQLiteDriver)
import FluentSQLiteDriver
#endif
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Use Postgres-Database, if URL passed as environment variable
    if let databaseURL = Environment.get("DATABASE_URL") {
        try app.databases.use(.postgres(url: databaseURL), as: .psql)
    }
    // Fallback to SQLite-Database for local development
    else {
        #if canImport(FluentSQLiteDriver)
        app.databases.use(.sqlite(), as: .sqlite)
        #endif
    }

    // add migrations
    migrations(app)

    #if DEBUG
        try await app.autoMigrate()
    #endif

    // register routes
    try routes(app)
}
