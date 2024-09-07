//
//  MemoirMonth+CoreDataProperties.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//
//

import Foundation
import CoreData


extension MemoirMonth {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoirMonth> {
        return NSFetchRequest<MemoirMonth>(entityName: "MemoirMonth")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var memoirs: NSSet?
    
    public var memoirArray: [Memoir] {
        let set = memoirs as? Set<Memoir> ?? []
        
        return set.sorted {
            $0.timestamp < $1.timestamp
        }
    }

}

// MARK: Generated accessors for memoirs
extension MemoirMonth {

    @objc(addMemoirsObject:)
    @NSManaged public func addToMemoirs(_ value: Memoir)

    @objc(removeMemoirsObject:)
    @NSManaged public func removeFromMemoirs(_ value: Memoir)

    @objc(addMemoirs:)
    @NSManaged public func addToMemoirs(_ values: NSSet)

    @objc(removeMemoirs:)
    @NSManaged public func removeFromMemoirs(_ values: NSSet)

}

extension MemoirMonth : Identifiable {

}
