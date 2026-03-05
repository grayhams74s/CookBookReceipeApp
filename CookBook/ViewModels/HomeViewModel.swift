//
//  HomeViewModel.swift
//  CookBook
//
//  Created by felix angcot jr on 2/28/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
class HomeViewModel {
    
    var showSignOutAlert = false
    var showAddReceipeView = false
    var receipes: [Receipe] = []
    var isFetching = false
    
    
    func fetchReceipes() async {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        do {
            isFetching = true
            receipes.removeAll()
            let receipesResult = try await Firestore.firestore().collection("receipes").whereField("ownerID", isEqualTo: userID).getDocuments()
            
            for receipeDocument in receipesResult.documents {
                let data = receipeDocument.data()
                
                guard let imageLocation = data["image"] as? String else {
                    continue
                }
                
                guard let instructions = data["instructions"] as? String else {
                    continue
                }
                
                guard let name = data["name"] as? String else {
                    continue
                }
                
                guard let time = data["time"] as? Int else {
                    continue
                }
                
                guard let ownerID = data["ownerID"] as? String else {
                    continue
                }
                
                let id = receipeDocument.documentID
                let receipe = Receipe(id: id, ownerID: ownerID, name: name, image: imageLocation, instructions: instructions, time: time)
                receipes.append(receipe)
                isFetching = false
                
            }
        } catch {
            isFetching = false
        }
        
        
    }
    
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            print("Sign out failed: \(error)")
            return false
        }
    }
}
