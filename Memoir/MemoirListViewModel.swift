//
//  ContentViewViewModel.swift
//  Memoir
//
//  Created by Vadim Shalugin on 17.09.2024.
//

import SwiftUI
import CoreData

class MemoirListViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext
    @Published var months: [MemoirMonth] = []
    
    init(context: NSManagedObjectContext) {C
        self.viewContext = context
        fetchMonths()
    }
    
    func fetchMonths() {
        let request: NSFetchRequest<MemoirMonth> = MemoirMonth.fetchRequest()
        request.sortDescriptors = []
        do {
            months = try viewContext.fetch(request)
        } catch {
            print("Error fetching data: \(error)")
        }
    }

    func addItem() {
        withAnimation {
            let newItem = MemoirMonth(context: viewContext)
            newItem.date = Date()
            newItem.id = UUID()
            saveContext()
            fetchMonths()
        }
    }

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let month = months[index]
                viewContext.delete(month)
            }
            saveContext()
            fetchMonths()
        }
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
