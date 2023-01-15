//
//  ImageGeneratorViewModel.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import Foundation

@MainActor final class ImageGeneratorViewModel: ObservableObject {
    @Published var imageURL: URL?
    
    func createImage(prompt: String) async {
        imageURL = nil
        
        do {
            guard let url = try await OpenAIService.shared.createImage(prompt: prompt) else {
                return
            }
            
            imageURL = url
        } catch {
            print(error.localizedDescription)
        }
    }
}
