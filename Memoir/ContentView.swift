//
//  ContentView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 07.09.2024.
//

import SwiftUI

struct ContentView: View {
    @State var items: [Memoir]
    @State private var currentText: String = ""
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        TextEditor(text: $currentText)
                            .foregroundStyle(.primary)
                            .padding(.horizontal)
                            .navigationTitle(dateFormatter.string(from: Date()))
                    } label: {
                        Text(dateFormatter.string(from: item.timestamp))
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
            let newItem = Memoir(timestamp: Date(), title: "", text: "")
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
