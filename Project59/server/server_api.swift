//
//  server_interface.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Foundation
import Vapor

struct Groups: Content {
    struct Group: Content {
        let id: Int
        let group: String
        let target: Float
        let start_time: Date
        let stoptime: Date
    }
    let Groups: [Group]
}


struct Consumption: Content {
    struct Consumed: Content {
        let username: String
        let drink: String
        let time: Date
    }
    let Consumption: [Consumed]
   
}


struct Drinks: Content {
    struct Drink: Content {
        let group_id: String
        let drink: String
        let weight: Float
    }
    let Drinks: [Drink]
   
}
