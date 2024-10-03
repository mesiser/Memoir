//
//  MemoirListView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import SwiftUI
import CoreData

struct MemoirListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel: MemoirListViewModel
    
    init(context: NSManagedObjectContext) {
        self.viewModel = MemoirListViewModel(context: context)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.months, id: \.self) { month in
                    NavigationLink {
                        MemoirMonthView(month: month, viewContext: viewContext)
                    } label: {
                        Text(DateConverter.month.string(from: month.date))
                    }
                }
                .onDelete(perform: viewModel.deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchMonths()  // Start data fetch after assigning the context
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        MemoirListView(context: viewContext)
    }
}

// Crash on deleting month
// Deactivate scroll on TextEditor
// Doesn't scroll automatically to bottom
// Save day as header on scroll
// Scroll to bottom on opening month
// Add new day on swipe down
// Add search on swipe up
// Show images on swipe left
// Add images/delete memoir on swipe right
// Show icon if there are images
