//
//  packageDescription.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Foundation
import PackageDescription

let package = Package(
    name: "Project59",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.77.1"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.8.0"),
        // ὁ8 Fluent driver for Postgres.
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.7.2"),
        .package(url: "https://github.com/vapor/fluent-sqlite-driver.git", from: "4.5.0")

    ],
    targets: [
        .executableTarget(
            name: "Project59",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "FluentSQLiteDriver", package: "fluent-sqlite-driver", condition: .when(platforms: [.macOS])),
                .product(name: "Vapor", package: "vapor")
            ]
        ),
    
    ]
)
