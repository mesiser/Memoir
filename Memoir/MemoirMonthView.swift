//
//  MemoirMonthView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 08.09.2024.
//

import SwiftUI

struct MemoirMonthView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var memoirMonth: MemoirMonth

    var body: some View {
        List {
            ForEach(memoirMonth.memoirArray) { memoir in
                MemoirView(memoir: memoir)
            }.onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
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

#Preview {
    MemoirMonthView(memoirMonth: .init())
}
