//
//  ViewHeightKey.swift
//  Memoir
//
//  Created by Vadim Shalugin on 17.09.2024.
//

import SwiftUI

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
