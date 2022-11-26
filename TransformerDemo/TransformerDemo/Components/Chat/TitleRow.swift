//
//  TitleRow.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//
import SwiftUI

struct TitleRow: View {
    @EnvironmentObject var messageManager: MessageManager
    var image_url = URL(string: "https://images.unsplash.com/photo-1567532939604-b6b5b0db2604?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8")
    var name = "Sarah Smith"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: image_url) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("Primary"))
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(Color("Secondary"))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if messageManager.isLoading {
                ProgressView()
            } else {
                Image(systemName: "phone.fill")
                    .foregroundColor(Color("Primary"))
                    .padding(10)
                    .background(Color("Content"))
                    .cornerRadius(50)
            }

        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        TitleRow()
            .environmentObject(MessageManager())
    }
}
