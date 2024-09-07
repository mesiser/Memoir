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
    var title: String
    var text: String
    
    init(timestamp: Date, title: String, text: String) {
        self.timestamp = timestamp
        self.title = title
        self.text = text
    }
}
