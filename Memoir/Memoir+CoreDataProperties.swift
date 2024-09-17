//
//  Memoir+CoreDataProperties.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//
//

import CoreData
import Foundation

public extension Memoir {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Memoir> {
        return NSFetchRequest<Memoir>(entityName: "Memoir")
    }

    @NSManaged var id: UUID
    @NSManaged var timestamp: Date
    @NSManaged var title: String?
    @NSManaged var text: String?
    @NSManaged var month: MemoirMonth
}

extension Memoir: Identifiable {}
