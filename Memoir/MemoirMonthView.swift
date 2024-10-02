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
    @FocusState var isInputActive: Bool

    var body: some View {
        List {
            ForEach(memoirMonth.memoirArray) { memoir in
                MemoirView(memoir: memoir, isInputActive: $isInputActive)
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
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    print(isInputActive)
                    isInputActive = false
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
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

struct MemoirMonthViewPreviews: PreviewProvider {
    static var dataController = DataController()
    @FocusState static private var isInputActive: Bool

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        let sampleMemoirMonth = MemoirMonth(context: viewContext)
        sampleMemoirMonth.date = Date()
        sampleMemoirMonth.id = UUID()

        return MemoirMonthView(memoirMonth: sampleMemoirMonth, isInputActive: _isInputActive)
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
