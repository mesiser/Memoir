//
//  MemoirMonth+CoreDataProperties.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//
//

import CoreData
import Foundation

public extension MemoirMonth {
    @nonobjc class func fetchRequest() -> NSFetchRequest<MemoirMonth> {
        return NSFetchRequest<MemoirMonth>(entityName: "MemoirMonth")
    }

    @NSManaged var date: Date
    @NSManaged var id: UUID
    @NSManaged var memoirs: NSSet?

    var memoirArray: [Memoir] {
        let set = memoirs as? Set<Memoir> ?? []

        return set.sorted {
            $0.timestamp < $1.timestamp
        }
    }
}

// MARK: Generated accessors for memoirs

public extension MemoirMonth {
    @objc(addMemoirsObject:)
    @NSManaged func addToMemoirs(_ value: Memoir)

    @objc(removeMemoirsObject:)
    @NSManaged func removeFromMemoirs(_ value: Memoir)

    @objc(addMemoirs:)
    @NSManaged func addToMemoirs(_ values: NSSet)

    @objc(removeMemoirs:)
    @NSManaged func removeFromMemoirs(_ values: NSSet)
}

extension MemoirMonth: Identifiable {}
