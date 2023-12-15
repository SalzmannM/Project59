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

struct DrinkByGroup: Decodable, Encodable {
    let group: String
}


struct ConsumedUpdate: Decodable , Encodable{
    let username: String
    let group: String
    let drink: String
}

struct DrinkQuery: Decodable, Encodable{
    let username: String
    let group: String
}

struct RankingQuery: Decodable, Encodable{
    let group: String
}

struct ConsumedResponse: Decodable, Identifiable{
    let id: UUID
    let username: String
    let group: String
    let drink: String
    let time: String
    let count: Int
}

struct Rank_Entry: Decodable , Encodable, Identifiable{
    let id: UUID
    let user: String
    let group: String
    let score: Float
}
