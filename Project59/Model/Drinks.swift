//
//  Drinks.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation
import SwiftData

@Model
class Drinks {
    var id: UUID?
    var group: String
    var drink: String
    var weight: Float

    init(id: UUID? = nil, group: String, drink: String, weight: Float) {
        self.id = id
        self.group = group
        self.drink = drink
        self.weight = weight
       
    }
}
