//
//  MessageField.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct MessageField: View {
    @State private var message = ""
    @EnvironmentObject var messageManager: MessageManager;

    var body: some View {
        HStack {
            // Custom text field created below
            CustomTextField(text: $message, placeholder: Text("Enter your message here").foregroundColor(.white))
                .frame(height: 52)
                .disableAutocorrection(true)

            Button {
                messageManager.addMessage(text: message, received: false)
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("AccentColor"))
                    .cornerRadius(50)
            }
        }
        .padding(10)
        .padding(.horizontal, 20)
        .background(Color("Background"))
        .cornerRadius(50)
        .padding()
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField()
            .environmentObject(MessageManager())
    }
}

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: Text
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }

    var body: some View {
        ZStack(alignment: .leading) {
            // If text is empty, show the placeholder on top of the TextField
            if text.isEmpty {
                placeholder.opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .foregroundColor(.white)
        }
    }
}
