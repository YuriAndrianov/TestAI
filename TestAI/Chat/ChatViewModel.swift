//
//  ChatViewModel.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

@MainActor final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func send(message: String) async {
        messages.append(.init(text: message, isOutgoing: true))
        
        do {
            guard let answer = try await OpenAIService.shared.send(message: message) else {
                return
            }
            
            messages.append(.init(text: answer, isOutgoing: false))
        } catch {
            print(error.localizedDescription)
        }
    }
}
