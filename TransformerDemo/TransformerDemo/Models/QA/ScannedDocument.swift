//
//  ScannedDocument.swift
//  TransformerDemo
//
//  Created by qiushi on 11/27/22.
//

import Foundation

import Foundation

struct ScannedDocument: Identifiable {
    var id = UUID()
    let content: String

    init(content: String) {
        self.content = content
    }
}
