//
//  Item.swift
//  Calendar
//
//  Created by Владислав Лесовой on 11.12.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
