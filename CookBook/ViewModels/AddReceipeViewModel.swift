//
//  AddReceipeViewModel.swift
//  CookBook
//
//  Created by felix angcot jr on 2/24/26.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore


@Observable
class AddReceipeViewModel {
 
      var receipeName = ""
      var preparationTime = 0
      var instructions = ""
      var showImageOptions = false
      var showImageLibrary = false
      var displayedReceipeImage: Image?
      var receipeImage: UIImage?
      var showCamera = false
      var uploadProgress: Float = 0
      var isUploading = false
      var isSuccess = false
      var showAlert = false
      var alertTitle = ""
      var alertMessage = ""
    
    func addReceipe() async -> Bool {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            alertTitle = "Not Signed In"
            alertMessage = "Please Sign in to create receipes."
            showAlert = true
            return false
        }

        
        guard receipeName.count >= 2 else {
            alertTitle = "Invalid Receipe Name"
            alertMessage = "Receipe name must be 2 or more characters long."
            showAlert = true
            return false
        }
        guard let imageURL = await upload() else {
            alertTitle = "Image Upload Failed"
            alertMessage = "Your receipe image could not be uploaded. Please try again."
            showAlert = true
             return false
        }
        
        guard instructions.count >= 5 else {
            alertTitle = "Invalid instructions"
            alertMessage = "Preparation time must be greater than 0 minutes"
            showAlert = true
            return false
        }
            
        let receipeID = UUID().uuidString.lowercased().replacingOccurrences(of: ("-"), with: "_")
        
        let receipe = Receipe(id: receipeID, ownerID: userID, name: receipeName, image: imageURL.absoluteString, instructions: instructions, time: preparationTime)
        
        let success = await uploadRecipe(receipe)
        guard success else {
            alertTitle = "Could Not Save Receipe"
            alertMessage = "We could not save your receipe right now, please try again later."
            showAlert = true
            return false
        }
        return true
        
    }
    
    func upload() async -> URL?{
        isUploading = true
        guard let userID = Auth.auth().currentUser?.uid else { return nil }
        
        guard let receipeImage = receipeImage, let imageData = receipeImage.jpegData(compressionQuality: 0.7) else { return nil }
        
       
        
        let imageID = UUID().uuidString.lowercased().replacingOccurrences(of: ("-"), with: "_")
        let imageName = "\(imageID).jpg"
        let imagePath = "images/\(userID)/\(imageName)"
        let storageRef = Storage.storage().reference(withPath: imagePath)
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        do {
            let result = try await storageRef.putDataAsync(imageData, metadata: metaData) { progress in
                if let progress = progress {
                    let percentComplet = Float (progress.completedUnitCount / progress.totalUnitCount)
                    self.uploadProgress = percentComplet
                }
            }
            let results = result
            let downloadURL = try await storageRef.downloadURL()
            return downloadURL
        } catch {
            alertTitle = "Image Upload Failed"
            alertMessage = "Your receipe image could not be uploaded. Please try again."
            showAlert = true
            isUploading = false
            return nil
        }
     
    }
    
    func uploadRecipe(_ recipe: Receipe) async -> Bool {
        do {
            try Firestore.firestore().collection("receipes").document(recipe.id).setData(from: recipe)
            isSuccess = true
            return true
            
        } catch {
            print("ERROR")
            isUploading = false
            return false
        }
     
    }
    
    func resetForm() {
        receipeName = ""
        preparationTime = 0
        instructions = ""
        showImageOptions = false
        showImageLibrary = false
        displayedReceipeImage = nil
        receipeImage = nil
        showCamera = false
        uploadProgress = 0
        isUploading = false
    }
}
 
