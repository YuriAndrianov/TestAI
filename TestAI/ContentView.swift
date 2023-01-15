//
//  ContentView.swift
//  TestAI
//
//  Created by Yuri Andrianov on 15.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ChatView()
                .tabItem {
                    Label("ChatGPT", systemImage: "message")
                }
            
            ImageGeneratorView()
                .tabItem {
                    Label("Image generator", systemImage: "photo")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
