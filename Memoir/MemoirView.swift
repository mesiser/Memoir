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

    init(memoir: Memoir) {
        self.memoir = memoir
        self._currentText = State(wrappedValue: memoir.text ?? "")
    }

    var body: some View {
        Section(content: {
            ZStack(alignment: .leading) {
                // Hidden Text to measure the height
                Text(currentText).foregroundColor(.clear).padding(6)
                    .background(GeometryReader { geometry in
                        Color.clear.preference(key: ViewHeightKey.self, value: geometry.frame(in: .local).size.height)
                    })

                // Actual TextEditor
                TextEditor(text: $currentText)
                    .onChange(of: currentText) { value in
                        memoir.text = value
                        saveMemoir()
                    }
                    .padding(.horizontal, -4)
                    .frame(minHeight: height)
                    .foregroundStyle(.primary)
                    .listRowSeparator(.hidden)
            }
            .onPreferenceChange(ViewHeightKey.self) { height = $0 }
        }, header: {
            Text(DateConverter.day.string(from: memoir.timestamp))
        })
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
