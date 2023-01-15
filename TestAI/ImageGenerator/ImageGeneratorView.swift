//
//  ImageGeneratorView.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

struct ImageGeneratorView: View {
    @ObservedObject var viewModel = ImageGeneratorViewModel()
    
    @State private var enteredText = ""
    @State private var isGenerating: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let url = viewModel.imageURL {
                    AsyncImage(url: url) { image in
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
                    Text(isGenerating ? "Generating..." : "Generate some image with typing below")
                        .font(.headline)
                        .padding()
                }
                Spacer()
                InputView(
                    enteredText: $enteredText,
                    textFieldPlaceholder: "Enter what you want to generate...",
                    buttonTitle: "Generate"
                ) {
                    let text = enteredText
                    enteredText = ""
                    
                    isGenerating = true
                    
                    Task {
                        await viewModel.createImage(prompt: text)
                        isGenerating = false
                    }
                }
            }
            .navigationTitle("Image generator")
        }
    }
}

struct ImageGeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGeneratorView()
    }
}
