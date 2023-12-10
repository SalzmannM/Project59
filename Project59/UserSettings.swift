//
//  UserSettings.swift
//  Project59
//
//  Created by Maurice Salzmann on 08.12.23.
//

import Foundation
import SwiftUI

@Observable class UserSettings:Codable {
    static let shared = UserSettings()
    
    private var savedInstance: UserSettings? {
        get {
            let decoder = JSONDecoder()
            if let data = UserDefaults.standard.data(forKey: "userSettings"),
               let decoded = try? decoder.decode(UserSettings.self, from: data) {
                return decoded
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let newValue, let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: "userSettings")
            } else {
                UserDefaults.standard.removeObject(forKey: "userSettings")
            }
        }
    }
    
    private init() {
        if let savedInstance {
            nickName = savedInstance.nickName
            groupName = savedInstance.groupName
        }
    }

    var nickName = "" {
        didSet {
            savedInstance = self
        }
    }
    
    var groupName = "" {
        didSet {
            savedInstance = self
        }
    }
}
