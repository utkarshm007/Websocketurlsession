//
//  ContentView.swift
//  Websocketurlsession
//
//  Created by Mishra, Utkarsh on 16/04/25.
//

import SwiftUI
import Foundation

struct ChatView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    @State private var messageText: String = ""
    let username: String

    var body: some View {
        VStack {
            ScrollView {
                ForEach(webSocketManager.messages, id: \.self) { message in
                    Text(message)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                }
            }

            HStack {
                TextField("Enter message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: 30)

                Button("Send") {
                    webSocketManager.send(message: messageText, from: username)
                    messageText = ""
                }
                .disabled(messageText.isEmpty)
            }
            .padding()
        }
        .onAppear {
            webSocketManager.connect()
        }
        .onDisappear {
            webSocketManager.disconnect()
        }
    }
}


struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
}
