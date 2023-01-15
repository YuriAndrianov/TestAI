//
//  ChatViewModel.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

final class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    private var service = ChatService()
    
    func send(text: String) {
        messages.append(.init(text: text, isOutgoing: true))
        
        service.send(text: text) { [weak self] result in
            self?.handleSendResult(result: result)
        }
    }
    
    private func handleSendResult(result: Result<String, Error>) {
        switch result {
        case .success(let answer):
            DispatchQueue.main.async { [weak self] in
                self?.messages.append(.init(text: answer, isOutgoing: false))
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
