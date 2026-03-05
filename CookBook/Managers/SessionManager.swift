//
//  SessionManager.swift
//  CookBook
//
//  Created by felix angcot jr on 2/23/26.
//

import Foundation
import FirebaseAuth
import FirebaseCore


@Observable
class SessionManager {
    
    var sessionState: SessionState = .loggedOut
    var currentUser: User?
    
    init () {
        if FirebaseApp.allApps == nil {
            FirebaseApp.configure()

        }
        sessionState = Auth.auth().currentUser != nil ? .loggedIn : .loggedOut
    }
    
}
