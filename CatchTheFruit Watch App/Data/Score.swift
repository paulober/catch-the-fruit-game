//
//  Stats.swift
//  CatchTheFruit Watch App
//
//  Created by Paul on 04.01.24.
//

import Foundation
import SwiftData

@Model
class Score {
    @Attribute(.unique) var id: UUID
    var score: UInt16
    var date: Date
    
    init(id: UUID, score: UInt16, date: Date) {
        self.id = id
        self.score = score
        self.date = date
    }
}
