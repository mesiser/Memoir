//
//  ContentView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import SwiftUI
import CoreData

enum DateConverter {
    static var month: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }()

    static var day: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter
    }()
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject private var viewModel: ContentViewModel
    
    init(context: NSManagedObjectContext) {
        self.viewModel = ContentViewModel(context: context)
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.months, id: \.self) { month in
                    NavigationLink {
                        MemoirMonthView(memoirMonth: month)
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
        ContentView(context: viewContext)
    }
}

struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat { 0 }
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value + nextValue()
    }
}
