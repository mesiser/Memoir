//
//  MemoirView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 08.09.2024.
//

import SwiftUI
import CoreData

struct MemoirView: View {
    @StateObject private var viewModel: MemoirViewModel
    @FocusState.Binding var isInputActive: Bool
    @State private var height = CGFloat.zero

    init(memoir: Memoir, viewContext: NSManagedObjectContext, isInputActive: FocusState<Bool>.Binding) {
        _viewModel = StateObject(wrappedValue: MemoirViewModel(memoir: memoir, viewContext: viewContext))
        self._isInputActive = isInputActive
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(DateConverter.day.string(from: viewModel.timestamp))
                .font(.headline) // Optional, for styling the header

            ZStack(alignment: .leading) {
                Text(viewModel.currentText).foregroundColor(.clear).padding(6)
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: ViewHeightKey.self, value: geometry.frame(in: .local).size.height)
                    })

                TextEditor(text: $viewModel.currentText)
                    .onChange(of: viewModel.currentText) { value in
                        viewModel.saveMemoir()
                    }
                    .padding(.horizontal, -4)
                    .frame(minHeight: height > 0 ? height : 100)
                    .foregroundStyle(.primary)
                    .focused($isInputActive)
            }
            .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        }
    }
}

struct MemoirViewPreviews: PreviewProvider {
    static var dataController = DataController()
    @FocusState static private var isInputActive: Bool

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        let sampleMemoir = Memoir(context: viewContext)
        sampleMemoir.text = "Sample Memoir Text"
        sampleMemoir.timestamp = Date()

        return MemoirView(memoir: sampleMemoir, viewContext: viewContext, isInputActive: $isInputActive)
            .environment(\.managedObjectContext, viewContext)
    }
}
