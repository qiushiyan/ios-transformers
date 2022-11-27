//
//  DrawingPadView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct CanvasView {}

struct DrawingPadView: View {
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0
    @State private var color = Color.white
    @StateObject private var drawingManager = DrawingManager()
    private var pad: some View {
        return Canvas { context, _ in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
        }

        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged { value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                self.lines.append(currentLine)
            }
            .onEnded { _ in
                self.lines.append(currentLine)
                self.currentLine = Line(points: [], color: color, lineWidth: thickness)
            }
        )
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: { self.lines = [] }) {
                    Text("Clear").font(.title2).fontWeight(.bold)
                }
                if let result = drawingManager.result {
                    Text(result)
                } else {
                    Spacer()
                }
                Button("Classify") {
                    let renderer = ImageRenderer(content: pad)
                    if let image = renderer.uiImage {
                        drawingManager.classify(image)
                    }
                }.font(.title2).fontWeight(.bold)
            }.padding(.horizontal, 40)

            Spacer()

            pad
                .padding()
                .background(.black)
                .frame(width: 400, height: 600)

            VStack {
//                HStack {
//                    Text("Color").foregroundColor(Color("AccentColor"))
//                    ColorPicker("", selection: $color)
//                        .onChange(of: color) { newColor in
//                            self.currentLine.color = newColor
//                        }
//                }.frame(maxWidth: 100)

                HStack {
                    Text("Thickness").foregroundColor(Color("AccentColor"))
                    Slider(value: $thickness, in: 1 ... 20) {
                        Text("Thickness")
                    }
                    .onChange(of: thickness) { newThickness in
                        currentLine.lineWidth = newThickness
                    }
                    .frame(maxWidth: 100)
                }.frame(maxWidth: 200)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Content"))
    }
}

struct DrawingPadView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingPadView()
    }
}
