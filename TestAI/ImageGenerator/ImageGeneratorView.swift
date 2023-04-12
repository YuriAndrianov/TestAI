//
//  ImageGeneratorView.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

struct ImageGeneratorView: View {
    @StateObject var viewModel = ImageGeneratorViewModel()
    
    @State private var enteredText = ""
    @State private var isGenerating: Bool = false
    @State private var prompt: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                ImageView(imageURL: viewModel.imageURL, isGenerating: isGenerating)
                Text(prompt)
                    .font(.headline)
                    .padding()
                Spacer()
                InputView(
                    enteredText: $enteredText,
                    textFieldPlaceholder: "Enter what you want to generate...",
                    buttonTitle: "Generate"
                ) { buttonAction() }
            }
            .navigationTitle("Image generator")
        }
    }
    
    private func buttonAction() {
        let text = enteredText
        enteredText = ""
        
        isGenerating = true
        prompt = text
        
        Task {
            await viewModel.createImage(prompt: text)
            isGenerating = false
        }
    }
}

private struct ImageView: View {
    let imageURL: URL?
    let isGenerating: Bool
    
    var body: some View {
        if let imageURL {
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .scaledToFit()
                    .cornerRadius(12)
                    .frame(width: UIScreen.main.bounds.width - 32)
            } placeholder: {
                ProgressView()
            }
        } else {
            Text(getPlaceholderText())
                .font(.headline)
                .padding()
        }
    }
    
    private func getPlaceholderText() -> String {
        return isGenerating ? "Generating..." : "Generate some image with typing below"
    }
}

struct ImageGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGeneratorView()
    }
}
