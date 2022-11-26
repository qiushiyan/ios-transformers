//
//  MessageBubble.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    var max_width: Double = 300
    var alignment: Alignment {
        message.received ? .leading : .trailing
    }
    @State private var showTime = false

    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("Primary") : Color("Secondary"))
                    .cornerRadius(30)
            }
            .frame(
                maxWidth: max_width,
                alignment: alignment
            )
            .onTapGesture {
                showTime.toggle()
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(Color("Info"))
            }
        }
        .frame(maxWidth: .infinity, alignment: alignment)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MessageBubble(message: messageDemo1)
                .previewDisplayName("message sent")

            MessageBubble(message: messageDemo2)
                .previewDisplayName("message received")
        }
    }
}
