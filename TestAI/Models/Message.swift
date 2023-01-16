//
//  Message.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import Foundation

struct Message {
    var id = UUID().uuidString
    let text: String
    let isOutgoing: Bool
    
    init(text: String, isOutgoing: Bool) {
        let lines = text.split(whereSeparator: \.isNewline)
        let textWithoutEmptyLines = lines.joined(separator: "\n")
        
        self.text = textWithoutEmptyLines
        self.isOutgoing = isOutgoing
    }
}
