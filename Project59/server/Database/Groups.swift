//
//  Groups.swift
//  Project59
//
//  Created by Thomas Stadelmann on 03.12.2023.
//

import Foundation
import Fluent
import Vapor

final class Consumed: Model, Content {
    static let schema = "Project59"

    @ID(key: .id)
    var group_id: String?

    @Field(key: "drink")
    var group: String

    @Field(key: "target")
    var target: Float
    
    @Field(key: "start_time")
    var start_time: Date
    
    @Field(key: "stop_time")
    var stop_time: Date

    init() { }

    init(group_id: String, drink: String, target: Float, start_time: Date, stop_time: Float) {
        self.group_id = group_id
        self.drink = drink
        self.target = target
        self.start_time = start_time
        self.stop_time = stop_time
       
    }
}
