//
//  Networking.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation

@Observable class Networking {
    static let shared = Networking()
    
    var groups: GroupsResponse?
    
    var drinks: DrinksResponse?
    
    private let baseUrl = URL(string: "https://66.241.124.102:8080/")!
    
    func loadGroups() async throws {
        let url = baseUrl.appendingPathComponent("group")
        let data = try await URLSession.shared.data(from: url)
        groups = try JSONDecoder().decode(GroupsResponse.self, from: data.0)
    }
    
    func loadDrinks() async throws {
        let url = baseUrl.appendingPathComponent("drink")
        let data = try await URLSession.shared.data(from: url)
        drinks = try JSONDecoder().decode(DrinksResponse.self, from: data.0)
    }
    
    
    func sendGroup(_ group: Groups) async throws {
        let url = baseUrl.appendingPathComponent("group")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let groupname = group.group
        let target = group.target
        let starttime = group.starttime
        let stoptime = group.stoptime
        let body = AddGroupRequestBody(group: groupname, target: target, starttime: starttime, stoptime: stoptime)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        _ = try await URLSession.shared.data(for: request)
        
    }
    
    func sendDrink(_ drink: Drinks) async throws {
        let url = baseUrl.appendingPathComponent("drink")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let drinkname = drink.drink
        let weight = drink.weight
        let group = drink.group
        let body = AddDrinkRequestBody(drink: drinkname, weight: weight, group: group)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        _ = try await URLSession.shared.data(for: request)
        
    }
    
    //consumption
}
