//
//  RegisterView.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import SwiftUI

struct RegisterView: View {
    
    @State var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(SessionManager.self) var sessionManager: SessionManager
    
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                // Username
                Text("Username")
                    .font(.system(size: 15))
                TextField("Username", text: $viewModel.username)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthTextFieldStyle())
                // Email
                Text("Email")
                    .font(.system(size: 15))
                TextField("Username", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthTextFieldStyle())
                // Password
                Text("Password")
                    .font(.system(size: 15))
                PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
                
                Button(action: {
                    Task {
                        if let user = await viewModel.signUp() {
                            sessionManager.currentUser = user
                            sessionManager.sessionState = .loggedIn
                        }
                        
                    }
                }, label: {
                    HStack {
                        Text("Sign In")
                        Image(systemName: "chevron.right")
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .padding(12)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                })
                
                
                HStack {
                    Spacer()
                    Text("Already have an account?")
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(.black.opacity(0.4))
                    
                    Button (action: {
                        dismiss()
                    }, label: {
                        Text("Login")
                            .font(.system(size: 15, weight: .light))
                    })
                    Spacer()
                }
                .padding(.top, 10)
                
                
                
            }
            .padding(.horizontal)
            if viewModel.isLoading {
                LoadingViewComponent()
            }
        }
        .alert("Error", isPresented: $viewModel.presentAlert) {
                    
        } message : {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    RegisterView()
        .environment(SessionManager())
}
