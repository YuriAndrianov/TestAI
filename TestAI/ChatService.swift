//
//  ChatService.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import OpenAISwift

final class ChatService {
    private enum Constants {
        static let authToken = "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"
        static let maxTokens = 500
    }
    
    private var openAI: OpenAISwift?
    
    init() {
        openAI = OpenAISwift(authToken: Constants.authToken)
    }
    
    func send(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        openAI?.sendCompletion(with: text, maxTokens: Constants.maxTokens) { result in
            switch result {
            case .success(let success):
                completion(.success(success.choices.first?.text ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
