//
//  Consumed.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Foundation
import Fluent
import Vapor

final class Consumed: Model, Content {
    static let schema = "Project59"

    @ID(key: .id)
    var username: String?

    @Field(key: "drink")
    var drink: String

    @Field(key: "time")
    var time: Date

    init() { }

    init(username: String, drink: String, time: Date) {
        self.username = username
        self.drink = drink
        self.time = time
       
    }
}
