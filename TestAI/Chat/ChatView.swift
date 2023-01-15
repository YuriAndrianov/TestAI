//
//  ChatView.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel = ChatViewModel()
    
    @State private var enteredText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollMessageView(messages: $viewModel.messages)
                InputView(
                    enteredText: $enteredText,
                    textFieldPlaceholder: "Enter message...",
                    buttonTitle: "Send"
                ) {
                    let message = enteredText
                    enteredText = ""
                    
                    Task {
                        await viewModel.send(message: message)
                    }
                }
            }
            .navigationTitle("ChatGPT")
        }
    }
}

private struct ScrollMessageView: View {
    @Binding var messages: [Message]
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.vertical) {
                LazyVStack {
                    ForEach(messages, id: \.id) { MessageView(message: $0) }
                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 16)
            .onChange(of: messages.count) { count in
                guard count > 0 else {
                    return
                }
                
                withAnimation {
                    proxy.scrollTo(messages[count - 1].id)
                }
            }
        }
    }
}

private struct MessageView: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isOutgoing {
                Spacer(minLength: 100)
            }
            ZStack(alignment: .leading) {
                messageColor()
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                 Text(message.text)
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical)
                    .layoutPriority(1)
            }
            if message.isOutgoing == false {
                Spacer(minLength: 50)
            }
        }
    }
    
    @ViewBuilder
    private func messageColor() -> some View {
        message.isOutgoing ? Color.green : Color.gray
    }
}

struct InputView: View {
    @Binding var enteredText: String
    
    let textFieldPlaceholder: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
    var body: some View {
        HStack {
            TextField(text: $enteredText) {
                Text(textFieldPlaceholder)
            }
            .textFieldStyle(.roundedBorder)
            Button {
                buttonAction()
            } label: {
                Text(buttonTitle)
            }
            .disabled(enteredText.isEmpty)
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
