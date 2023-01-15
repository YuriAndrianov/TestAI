//
//  ChatService.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import OpenAIKit
import Foundation

final class OpenAIService {
    private enum Constants {
        static let authToken = "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"
        static let organizationName = "Personal"
        static let maxTokens = 500
    }
    
    static let shared = OpenAIService()
    
    private var openAI: OpenAI?
    
    private init() {
        openAI = OpenAI(Configuration(
            organization: Constants.organizationName,
            apiKey: Constants.authToken
        ))
    }
    
    func send(message: String) async throws -> String? {
        do {
            let completionParameter = CompletionParameters(
                model: "text-davinci-001",
                prompt: [message],
                maxTokens: Constants.maxTokens,
                temperature: 0.9
            )
            
            let completionResponse = try await openAI?.generateCompletion(
                parameters: completionParameter
            )
            
            return completionResponse?.choices.first?.text
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    func createImage(prompt: String) async throws -> URL? {
        do {
            let imageParameters = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .url
            )
            
            let response = try await openAI?.createImage(
                parameters: imageParameters
            )
            
            guard let urlString = response?.data.first?.image else {
                return nil
            }
            
            return URL(string: urlString)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
}
