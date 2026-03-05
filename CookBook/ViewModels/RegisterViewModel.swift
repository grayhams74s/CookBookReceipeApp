//
//  RegisterViewModel.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
@Observable
class RegisterViewModel {
    
        var username = ""
        var email = ""
        var password = ""
        var showPassword = false
        var isLoading = false
        var errorMessage = ""
        var presentAlert = false
        
    
    
    
    
    func signUp() async -> User? {
        
        guard validateUsername() else {
            errorMessage = "Username must be greater than 3 characters and less than 25 characters."
            presentAlert = true
            return nil
        }
    
        isLoading = true
        
        guard let usernameDocuments = try? await Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments() else {
            errorMessage = "Something has gone wrong. Please try again later."
            presentAlert = true
            isLoading = false
            return nil
        }
        
        guard usernameDocuments.documents.count == 0 else {
          errorMessage = "Username already exists"
            presentAlert = true
            isLoading = false
            return nil
        }
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let userId = result.user.uid
            
            let userData = User(id: userId, username: username, email: email)
            
            try Firestore.firestore().collection("users").document(userId).setData(from: userData)
            
            isLoading = false
            return userData
            
    } catch {
        
            errorMessage = "Login Failed"
            // 1. Cast the generic error to NSError
            let nsError = error as NSError
            // 2. Access the error directly via AuthErrorCode
            if let errorCode = AuthErrorCode(rawValue: nsError.code) {
                switch errorCode {
                case .emailAlreadyInUse:
                    let message = "Email already taken."
                    errorMessage = message
                case .invalidEmail:
                    let message = "That email looks wrong."
                    errorMessage = message
                case .weakPassword:
                    let message = "Password is too short."
                    errorMessage = message
                case .wrongPassword:
                    let message = "Wrong is wrong"
                    errorMessage = message
                case .missingEmail:
                    let message = "Missing Email"
                    errorMessage = message
                default:
                    print("Auth Error: \(error.localizedDescription)")
                }
            }
            isLoading = false
            presentAlert = true
            return nil
        }
    }
    
    func validateUsername () -> Bool {
         username.count >= 3  &&  username.count < 25
    }
}


