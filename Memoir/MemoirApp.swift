//
//  MemoirApp.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import SwiftUI

@main
struct MemoirApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            let context = dataController.container.viewContext
            MemoirListView(context: context)
                .environment(\.managedObjectContext, context)
        }
    }
}
