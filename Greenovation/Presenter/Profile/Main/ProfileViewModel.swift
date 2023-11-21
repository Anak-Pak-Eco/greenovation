//
//  ProfileViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import FirebaseAuth
import FirebaseAuthCombineSwift

final class ProfileViewModel {
    
    let successUpdateProfile = Box(false)
    let errorUpdateProfile = Box("")
    let loadingProfile = Box(false)
    var editMode = false
    var user: User?
    
    func getUser() {
        user = Auth.auth().currentUser
    }
    
    func updateUser(name: String) {
        loadingProfile.value = true
        let request = user?.createProfileChangeRequest()
        request?.displayName = name
        request?.commitChanges { [unowned self] error in
            loadingProfile.value = false
            if let error = error {
                errorUpdateProfile.value = error.localizedDescription
                return
            }
            
            user = Auth.auth().currentUser
            successUpdateProfile.value = true
        }
    }
}
