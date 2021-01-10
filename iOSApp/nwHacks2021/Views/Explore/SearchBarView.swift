//
//  SearchBarView.swift
//  nwHacks2021
//
//  Created by Martin Yushko on 2021-01-09.
//

import SwiftUI

class AnyGestureRecognizer: UIGestureRecognizer {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touchedView = touches.first?.view, touchedView is UIControl {
            state = .cancelled
        } else if let touchedView = touches.first?.view as? UITextView, touchedView.isEditable {
            state = .cancelled
        } else {
            state = .began
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       state = .ended
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        state = .cancelled
    }
}

struct SearchBarView: View {
    @Binding var searchText: String
    @State private var isEditing: Bool = false

    let searchPrompt: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                TextField(searchPrompt, text: $searchText, onEditingChanged: { _ in
                    self.isEditing = true
                }, onCommit: {
                    self.isEditing = false
                }).foregroundColor(.primary)

                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                })
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)

            if isEditing {
                Button("Cancel") {
                    self.searchText = ""
                    self.isEditing = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""), searchPrompt: "Search...")
    }
}
