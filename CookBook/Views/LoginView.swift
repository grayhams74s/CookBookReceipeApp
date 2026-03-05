//
//  LoginView.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import SwiftUI

struct LoginView: View { 
    
    @State var viewModel = LoginViewModel()
    @Environment(SessionManager.self) var sessionManager: SessionManager
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading){
                Text("Email")
                    .font(.system(size: 15))
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthTextFieldStyle())
                
                Text("Password")
                    .font(.system(size: 15))
                PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
                
                Button(action: {
                    Task {
                        if let user = await viewModel.login(){
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
                    Text("Don't have an account?")
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(.black.opacity(0.4))
                    
                    Button(action: {
                        viewModel.presentRegisterView = true
                    },label: {
                        Text("Register Now")
                            .font(.system(size: 15, weight: .light))
                    })
                    Spacer()
                }
                .padding(.top, 5)
                
                
            }
            .padding(.horizontal, 10)
            .fullScreenCover(isPresented: $viewModel.presentRegisterView, content: {
                RegisterView()
            })
            if viewModel.isLoading {
                LoadingViewComponent()
            }
        }
        .alert("Error", isPresented: $viewModel.presentAlert) {
            
        } message: {
            Text(viewModel.errorMessage)
        }
        
    }
}

#Preview {
    LoginView()
        .environment(SessionManager())
}


