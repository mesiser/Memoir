//
//  MemoirMonthView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 08.09.2024.
//

import CoreData
import SwiftUI

struct MemoirMonthView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: MemoirMonthViewModel
    @FocusState private var isInputActive: Bool

    init(month: MemoirMonth, viewContext: NSManagedObjectContext) {
        _viewModel = StateObject(wrappedValue: MemoirMonthViewModel(memoirMonth: month, viewContext: viewContext))
    }

    var body: some View {
        ScrollViewReader { proxy in
            List {
                ForEach(viewModel.memoirs) { memoir in
                    MemoirView(memoir: memoir, viewContext: viewContext, isInputActive: $isInputActive)
                }.onDelete(perform: viewModel.deleteItems)
            }
            .listStyle(.plain)
            .navigationTitle(DateConverter.month.string(from: viewModel.memoirMonth.date))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: viewModel.addItem) {
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
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if let lastMemoir = viewModel.memoirs.last {
                        proxy.scrollTo(lastMemoir.id, anchor: .bottom)
                    }
                }
//                isInputActive = true
            }
            .onChange(of: isInputActive) { active in
                if active, let lastMemoir = viewModel.memoirs.last {
                    proxy.scrollTo(lastMemoir.id, anchor: .bottom)
                }
            }
        }
    }
}

struct MemoirMonthViewPreviews: PreviewProvider {
    static var dataController = DataController()
    @FocusState private static var isInputActive: Bool

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        let sampleMemoirMonth = MemoirMonth(context: viewContext)
        sampleMemoirMonth.date = Date()
        sampleMemoirMonth.id = UUID()

        return MemoirMonthView(month: sampleMemoirMonth, viewContext: viewContext)
            .environment(\.managedObjectContext, dataController.container.viewContext)
    }
}
