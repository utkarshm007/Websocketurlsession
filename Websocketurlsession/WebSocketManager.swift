import Foundation

class WebSocketManager: ObservableObject {
    private var webSocketTask: URLSessionWebSocketTask?  // variable that will hold the WebSocket task
    private let urlSession = URLSession(configuration: .default)  //  responsible for creating and managing the WebSocket connection
    @Published var messages: [String] = []

    func connect() {
        guard let url = URL(string: "ws://localhost:3000") else {
            print("Invalid URL")
            return
        }
        webSocketTask = urlSession.webSocketTask(with: url) //created a websocket task
        webSocketTask?.resume() //start or restart a websocket task
        receive()
    }

    func send(message: String, from username: String) {
        let fullMessage = "\(username): \(message)"
        let wsMessage = URLSessionWebSocketTask.Message.string(fullMessage)

        webSocketTask?.send(wsMessage) { error in
            if let error = error {
                print("WebSocket sending error: \(error)")
            }
        }
    }

//check in case of any error how can we provide a fallback method so that message does'nt get lost.

    private func receive() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("WebSocket receiving error: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    DispatchQueue.main.async {
                        self?.messages.append(text)
                    }
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    print("Received unknown message")
                }
                self?.receive()
            }
        }
    }

    func disconnect() {
        webSocketTask?.cancel(with: .goingAway, reason: nil)
    }
}
//
//  WebSocketManager.swift
//  Websocketurlsession
//
//  Created by Mishra, Utkarsh on 16/04/25.
//

