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
                Text(currentText).foregroundColor(.clear).padding(6)
                    .background(GeometryReader {
                        Color.clear.preference(key: ViewHeightKey.self, value: $0.frame(in: .local).size.height)
                    })
                TextEditor(text: $currentText)
                    .onChange(of: currentText) { value in
                        memoir.text = value
                        try? viewContext.save()
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
}

#Preview {
    MemoirView(memoir: .init())
}

