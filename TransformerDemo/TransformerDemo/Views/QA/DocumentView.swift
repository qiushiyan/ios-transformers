//
//  DocumentView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/27/22.
//

import SwiftUI

struct DocumentView: View {
    var content: String
    @EnvironmentObject private var model: BERT
    @State private var isLoading = false
    @State private var answer = ""
    @State private var question = ""

    var body: some View {
        ScrollView {
            Text(content)
                .padding()
                .foregroundColor(.white)

            if isLoading {
                ProgressView()
            }

            HStack {
                CustomTextField(text: $question, placeholder: Text("Question").foregroundColor(.white))
                    .padding()
                    .disableAutocorrection(true)

                Button {
                    DispatchQueue.global(qos: .userInitiated).async {
                        self.isLoading = true
                        let text = self.model.predict(for: question, in: content)
                        self.answer = String(text)
                        self.isLoading = false
                    }
                } label: {
                    Image(systemName: "paintbrush.pointed.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color("AccentColor"))
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal, 20)
            .background(Color("Background"))
            .cornerRadius(50)
            .padding()

            if let answer = answer {
                Text(answer)
                    .foregroundColor(Color("Info"))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle(content.prefix(20))
        .padding()
        .background(Color("Content"))
    }
}

struct DocumentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(content: contextDemo1).environmentObject(BERT())
    }
}
