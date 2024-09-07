//
//  Item.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
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
