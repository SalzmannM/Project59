//
//  NetworkingModels.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation

struct Group: Decodable, Identifiable {
    let group: String
    let id: String
    let target: Float
    let start: String
    let stop: String
}

struct Drink: Decodable, Identifiable {
    let group: String
    let drink: String
    let weight: Float
    let id: UUID
}


struct GroupUpdate: Decodable, Encodable {
    let group: String
    let target: Float
    let start: String
    let stop: String
}

struct DrinkUpdate: Decodable, Encodable {
    let group: String
    let drink: String
    let weight: Float
}
