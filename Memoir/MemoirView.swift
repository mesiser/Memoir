//
//  MemoirView.swift
//  Memoir
//
//  Created by Vadim Shalugin on 08.09.2024.
//

import SwiftUI

struct MemoirView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var currentText: String = ""
    @State var memoir: Memoir
    @State private var height = CGFloat.zero
    @FocusState var isInputActive: Bool

    init(memoir: Memoir) {
        self.memoir = memoir
        self._currentText = State(wrappedValue: memoir.text ?? "")
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(DateConverter.day.string(from: memoir.timestamp))
                .font(.headline) // Optional, for styling the header

            ZStack(alignment: .leading) {
                Text(currentText).foregroundColor(.clear).padding(6)
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: ViewHeightKey.self, value: geometry.frame(in: .local).size.height)
                    })

                TextEditor(text: $currentText)
                    .onChange(of: currentText) { value in
                        memoir.text = value
                        saveMemoir()
                    }
                    .padding(.horizontal, -4)
                    .frame(minHeight: height > 0 ? height : 100)
                    .foregroundStyle(.primary)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                            }
                        }
                    }
            }
            .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        }
    }

    private func saveMemoir() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save Memoir: \(error.localizedDescription)")
        }
    }
}

struct MemoirViewPreviews: PreviewProvider {
    static var dataController = DataController()

    static var previews: some View {
        let viewContext = dataController.container.viewContext
        let sampleMemoir = Memoir(context: viewContext)
        sampleMemoir.text = "Sample Memoir Text"
        sampleMemoir.timestamp = Date()

        return MemoirView(memoir: sampleMemoir)
            .environment(\.managedObjectContext, viewContext)
    }
}
