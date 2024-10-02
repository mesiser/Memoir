//
//  MemoirViewViewModel.swift
//  Memoir
//
//  Created by Vadim Shalugin on 02.10.2024.
//

import SwiftUI
import CoreData

class MemoirViewModel: ObservableObject {
    @Published var currentText: String
    private var memoir: Memoir
    private var viewContext: NSManagedObjectContext

    init(memoir: Memoir, viewContext: NSManagedObjectContext) {
        self.memoir = memoir
        self.viewContext = viewContext
        self.currentText = memoir.text ?? ""
    }

    func saveMemoir() {
        memoir.text = currentText
        do {
            try viewContext.save()
        } catch {
            print("Failed to save Memoir: \(error.localizedDescription)")
        }
    }

    var timestamp: Date {
        memoir.timestamp
    }
}
