//
//  DrawingManager.swift
//  TransformerDemo
//
//  Created by qiushi on 11/26/22.
//

import Foundation
import SwiftUI

class DrawingManager: ObservableObject {
    @Published var result: String?
    private var model: UpdatableDrawingClassifier

    init() {
        model = UpdatableDrawingClassifier()
    }

    func classify(_ img: UIImage) {
        if let buffer = img.toBuffer() {
            let output = try? model.prediction(drawing: buffer)
            if let output = output {
                print(output.labelProbs)
                result = output.label
            }
        }
    }

    func clearResult() {
        result = nil
    }
}
