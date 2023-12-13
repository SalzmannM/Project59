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
    
    var ranking: [ConsumedResponse]?
    
    var userRanking: [ConsumedResponse]?
    
    private let baseUrl = URL(string: "https://vapor-server59.fly.dev/")!
    
    func loadGroups() async throws {
        let url = baseUrl.appendingPathComponent("group")
        let data = try await URLSession.shared.data(from: url)
        groups = try JSONDecoder().decode([Group].self, from: data.0)
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
    
    func loadDrinks(_ group: String) async throws {
        
        let url = baseUrl.appendingPathComponent("drinkbygroup")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = DrinkByGroup(group: group)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        drinks = try JSONDecoder().decode([Drink].self, from: data)
    }
    
    func sendConsumption(username: String, group: String, drink: String) async throws {
        let url = baseUrl.appendingPathComponent("consumed")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = ConsumedUpdate(username: username, group: group, drink: drink)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        _ = try await URLSession.shared.data(for: request)
        
    }
    
    
    func loadRanking(_ group: String) async throws {
        
        let url = baseUrl.appendingPathComponent("rank")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = RankingQuery(group: group)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        ranking = try JSONDecoder().decode([ConsumedResponse].self, from: data)
    }
    
    func loadUserStats(group: String, user: String) async throws {
        
        let url = baseUrl.appendingPathComponent("user")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = DrinkQuery(username: user, group: group)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        userRanking = try JSONDecoder().decode([ConsumedResponse].self, from: data)
    }
}
