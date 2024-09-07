//
//  Memoir+CoreDataProperties.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//
//

import Foundation
import CoreData


extension Memoir {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memoir> {
        return NSFetchRequest<Memoir>(entityName: "Memoir")
    }

    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var title: String?
    @NSManaged public var text: String?

}

extension Memoir : Identifiable {

}
