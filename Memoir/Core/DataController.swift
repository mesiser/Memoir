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
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
