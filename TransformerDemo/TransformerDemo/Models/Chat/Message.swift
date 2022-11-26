//
//  Message.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id: String;
    var text: String;
    var received: Bool; 
    var timestamp: Date
}
