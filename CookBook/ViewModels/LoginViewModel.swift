//
//  LoginViewModel.swift
//  CookBook
//
//  Created by felix angcot jr on 2/21/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


@Observable
class LoginViewModel {
    
     var presentRegisterView = false
     var email = ""
     var password = ""
     var showPassword = false
     var errorMessage = ""
     var presentAlert = false
     var isLoading = false
        
    
    
    func login() async -> User? {
        isLoading = true
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userId = result.user.uid
            let user = try await Firestore.firestore().collection("users")
                .document(userId).getDocument(as: User.self)
            isLoading = false
            return user

        } catch {
            isLoading = false
            errorMessage = "Login Failed"
            // 1. Cast the generic error to NSError
            let nsError = error as NSError
            // 2. Access the error directly via AuthErrorCode
            if let errorCode = AuthErrorCode(rawValue: nsError.code) {
                switch errorCode {
                case .wrongPassword:
                    let message = "Wrong password"
                    errorMessage = message
                case .invalidEmail:
                    let message = "Invalid email"
                    errorMessage = message
                default:
                    break
                }
            }
            presentAlert = true
            return nil
        }
    }
    
    
}
