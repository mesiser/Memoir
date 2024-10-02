//
//  MemoirMonthViewMovel.swift
//  Memoir
//
//  Created by Vadim Shalugin on 02.10.2024.
//

import SwiftUI
import CoreData

class MemoirMonthViewModel: ObservableObject {
    @Published var memoirs: [Memoir] = []
    private var viewContext: NSManagedObjectContext
    var memoirMonth: MemoirMonth

    init(memoirMonth: MemoirMonth, viewContext: NSManagedObjectContext) {
        self.memoirMonth = memoirMonth
        self.viewContext = viewContext
        loadMemoirs()
    }

    private func loadMemoirs() {
        memoirs = memoirMonth.memoirArray
    }

    func addItem() {
        withAnimation {
            let newItem = Memoir(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.month = memoirMonth
            memoirMonth.addToMemoirs(newItem)
            saveContext()
            loadMemoirs()
        }
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let memoir = memoirs[index]
                viewContext.delete(memoir)
                memoirMonth.removeFromMemoirs(memoir)
            }
            saveContext()
            loadMemoirs()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Handle the error appropriately in a real app
            print("Error saving context: \(error)")
        }
    }
}
