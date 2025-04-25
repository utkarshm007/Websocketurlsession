//
//  LoginView.swift
//  Websocketurlsession
//
//  Created by Mishra, Utkarsh on 16/04/25.
//
import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            ChatView(username: username)
        } else {
            VStack(spacing: 20) {
                Text("Enter Username")
                    .font(.title)

                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button("Join Chat") {
                    if !username.isEmpty {
                        isLoggedIn = true
                    }
                }
                .disabled(username.isEmpty)
            }
            .padding()
        }
    }
}
