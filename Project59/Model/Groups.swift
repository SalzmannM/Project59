//
//  Groups.swift
//  Project59
//
//  Created by Maurice Salzmann on 10.12.23.
//

import Foundation
import SwiftData

@Model
class Groups {
    var id: UUID?
    var group: String
    var target: Float
    var starttime: Date
    var stoptime: Date

    init(id: UUID? = nil, group: String, target: Float, starttime: Date, stoptime: Date) {
        self.id = id
        self.group = group
        self.target = target
        self.starttime = starttime
        self.stoptime = stoptime
       
    }
    
    
}
