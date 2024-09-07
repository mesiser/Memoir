//
//  ContentView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import SwiftUI

enum DateConverter {
    static var month: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }()

    static var day: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter
    }()
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) var months: FetchedResults<MemoirMonth>

    var body: some View {
        NavigationView {
            List {
                ForEach(months) { month in
                    NavigationLink {
                        MemoirMonthView(memoirMonth: month)
                    } label: {
                        Text(DateConverter.month.string(from: month.date))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = MemoirMonth(context: viewContext)
            newItem.date = Date()
            newItem.id = UUID()
            try? viewContext.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let month = months[index]
                viewContext.delete(month)
                try? viewContext.save()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}

struct MemoirMonthView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var memoirMonth: MemoirMonth

    var body: some View {
        List {
            ForEach(memoirMonth.memoirArray) { _ in
                MemoirView()
            }.onDelete(perform: deleteItems)
        }
        .navigationTitle(DateConverter.month.string(from: memoirMonth.date))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Memoir(context: viewContext)
            newItem.timestamp = Date()
            newItem.id = UUID()
            newItem.month = memoirMonth
            memoirMonth.addToMemoirs(newItem)
            try? viewContext.save()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let memoir = memoirMonth.memoirArray[index]
                memoirMonth.removeFromMemoirs(memoir)
                try? viewContext.save()
            }
        }
    }
}

struct MemoirView: View {
    @State private var currentText: String = ""
//    @State var memoir: Memoir

    var body: some View {
        Section(content: {
            TextEditor(text: $currentText)
                .foregroundStyle(.primary)
                .padding(0)
        }, header: {
//            Text(DateConverter.day.string(from: memoir.timestamp))
        })
    }
}
