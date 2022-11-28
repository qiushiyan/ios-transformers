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
            QAView()
                .tabItem {
                    VStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Q & A")
                    }
                }
            DrawingPadView()
                .tabItem {
                    VStack {
                        Image(systemName: "paintpalette.fill")
                        Text("Paint")
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
