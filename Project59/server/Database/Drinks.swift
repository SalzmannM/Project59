//
//  Drinks.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Fluent
import Vapor

final class Drinks: Model, Content {
    static let schema = "Project59"

    @ID(key: .id)
    var group_id: Int?

    @Field(key: "drink")
    var drink: String

    @Field(key: "weight")
    var weight: float

    init() { }

    init(group_id: Int, drink: String, weight: Float) {
        self.group_id = group_id
        self.drink = drink
        self.weight = weight
       
    }
}
