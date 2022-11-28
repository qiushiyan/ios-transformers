//
//  QAView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct QAView: View {
    @State private var showScannerSheet = false
    @State private var documents: [ScannedDocument] = [documentDemo1, documentDemo2]
    @StateObject var model = BERT()

    var body: some View {
        NavigationView {
            VStack {
                if documents.count > 0 {
                    List {
                        ForEach(documents) { document in
                            NavigationLink(
                                destination: DocumentView(content: document.content).environmentObject(model),
                                label: {
                                    Text(document.content).lineLimit(1)
                                })
                        }
                        .onDelete(perform: delete)
                    }
                }
                else {
                    Text("No document yet").font(.title2)
                }
            }
            .navigationTitle("Documents")
            .navigationBarItems(trailing: Button(action: {
                self.showScannerSheet = true
            }, label: {
                Image(systemName: "doc.text.viewfinder")
                    .font(.title)
            })
            .sheet(isPresented: $showScannerSheet, content: {
                self.makeScannerView()
            })
            )
        }
        .background(Color("Content"))
    }

    func delete(at offsets: IndexSet) {
        documents.remove(atOffsets: offsets)
    }

    private func makeScannerView() -> ScannerView {
        ScannerView(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines) {
                let doc = ScannedDocument(content: outputText)
                self.documents.append(doc)
            }
            self.showScannerSheet = false
        })
    }
}

struct QAView_Previews: PreviewProvider {
    static var previews: some View {
        QAView()
    }
}
