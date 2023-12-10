//
//  NetworkingModels.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation

struct Group: Decodable, Identifiable {
    let group: String
    let target: Float
    let starttime: Date
    let stoptime: Date
    let id: UUID
}

struct Drink: Decodable, Identifiable {
    let group: String
    let drink: String
    let weight: Float
    let id: UUID
}

struct GroupsResponse: Decodable {
    let groups: [Group]
}

struct DrinksResponse: Decodable {
    let drinks: [Drink]
}


struct AddGroupRequestBody: Encodable {
    let group: String
    let target: Float
    let starttime: Date
    let stoptime: Date
}

struct AddDrinkRequestBody: Encodable {
    let drink: String
    let weight: Float
    let group: String
}
