//
//  MessageManager.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import Alamofire
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

class MessageManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var isLoading = false
    @Published private(set) var lastMessageId = ""
    let db = Firestore.firestore()
    let collection: CollectionReference
    let api_url = "http://localhost:8000/chat"
    
    init() {
        collection = db.collection("messages")
        getMessages()
    }
    
    func getMessages() {
        collection.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("error fetching messages: \(String(describing: error))")
                return
            }
            
            self.messages = documents.compactMap { document -> Message? in
                do {
                    return try document.data(as: Message.self)
                } catch {
                    print("Error decoding messages \(error)")
                    return nil
                }
            }
                
            self.messages.sort { $0.timestamp < $1.timestamp }
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    
    func addMessage(text: String, received: Bool) {
        do {
            let newMessage = Message(id: UUID().uuidString, text: text, received: received, timestamp: Date())
            try collection.document().setData(from: newMessage)
            // delay sending api requests since sometimes messages have not yet been updated on the python server
            self.isLoading = true 
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                if let api_url = self?.api_url {
                    AF.request(api_url, method: .post).responseData { response in
                        print(response)
                    }
                }
                self?.isLoading = false
            }

        } catch {
            print("Add message error \(error)")
        }
    }
}
