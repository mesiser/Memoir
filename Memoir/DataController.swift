//
//  DataController.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentCloudKitContainer(name: "Memoirs")
    
    init(forPreview: Bool = false) {
        if forPreview {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        if forPreview {
            addMockData(moc: container.viewContext)
        }
    }
}

extension DataController {
    func addMockData(moc: NSManagedObjectContext) {
        let memoirMonth = MemoirMonth()
        memoirMonth.id = UUID()
        memoirMonth.date = Date()
        try? moc.save()
    }
}
