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
}

struct ContentView: View {
    @State var items: [MemoirMonth]

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        MemoirMonthView(memoirMonth: item)
                    } label: {
                        Text(DateConverter.month.string(from: item.date))
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
            let newItem = MemoirMonth(date: Date(), memoirs: [])
            items.append(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                items.remove(at: index)
            }
        }
    }
}

#Preview {
    ContentView(items: [])
}

struct MemoirMonthView: View {
    @State private var currentText: String = ""
    @State var memoirMonth: MemoirMonth

    var body: some View {
        List {
            ForEach(memoirMonth.memoirs) { _ in
                TextEditor(text: $currentText)
                    .foregroundStyle(.primary)
                    .padding(0)
            }
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
            let newItem = Memoir(timestamp: Date(), title: "", text: "")
            memoirMonth.memoirs.append(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                memoirMonth.memoirs.remove(at: index)
            }
        }
    }
}
