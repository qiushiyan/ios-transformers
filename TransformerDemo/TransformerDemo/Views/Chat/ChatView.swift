//
//  ChatView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct ChatView: View {
    @StateObject var messagesManager = MessageManager()

    var body: some View {
        VStack {
            VStack {
                TitleRow().environmentObject(messagesManager)

                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 20)
                    .background(Color("Content"))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .onChange(of: messagesManager.lastMessageId) { id in
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            MessageField()
                .environmentObject(messagesManager)
        }
        .background(Color("Content"))
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        // let messages = [messageDemo1, messageDemo2]
        ChatView()
    }
}
