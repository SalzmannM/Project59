//
//  Networking.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation

@Observable class Networking {
    static let shared = Networking()
    
    var groups: [Group]?
    
    var drinks: [Drink]?
    
    private let baseUrl = URL(string: "https://vapor-server59.fly.dev/")!
    
    func loadGroups() async throws {
        let url = baseUrl.appendingPathComponent("group")
        let data = try await URLSession.shared.data(from: url)
        groups = try JSONDecoder().decode([Group].self, from: data.0)
    }
    
    func loadDrinks() async throws {
        let url = baseUrl.appendingPathComponent("drink")
        let data = try await URLSession.shared.data(from: url)
        drinks = try JSONDecoder().decode([Drink].self, from: data.0)
    }
    
    
    func sendGroup(group: String, target: Float, start: Date, stop: Date) async throws {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let url = baseUrl.appendingPathComponent("group")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = GroupUpdate(group: group, target: target, start: dateFormatter.string(from: start), stop: dateFormatter.string(from: stop))
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        
        _ = try await URLSession.shared.data(for: request)
        
    }
    
    func sendDrink(_ drink: String, weight: Float, group: String) async throws {
        let url = baseUrl.appendingPathComponent("drink")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = DrinkUpdate(group: group, drink: drink, weight: weight)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        _ = try await URLSession.shared.data(for: request)
        
    }
    
    //consumption
}
