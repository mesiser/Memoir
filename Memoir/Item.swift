//
//  Item.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import Foundation

struct Memoir: Identifiable {
    var id = UUID()
    var timestamp: Date
    var title: String
    var text: String
}

struct MemoirMonth: Identifiable {
    var id = UUID()
    var date: Date
    var memoirs: [Memoir]
}
