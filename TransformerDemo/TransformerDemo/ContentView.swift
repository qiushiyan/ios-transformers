//
//  ContentView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    VStack {
                        Image(systemName: "message.fill")
                        Text("GPT3")
                    }
                }
            DrawingPadView()
                .tabItem {
                    VStack {
                        Image(systemName: "paintpalette.fill")
                        Text("Paint")
                    }
                }
            QAView()
                .tabItem {
                    VStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Q & A")
                    }
                }
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
