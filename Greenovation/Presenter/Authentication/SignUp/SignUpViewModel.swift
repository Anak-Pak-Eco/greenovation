//
//  SignUpViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 03/11/23.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseAuthCombineSwift
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore
import UIKit
import AuthenticationServices
import CryptoKit

final class SignUpViewModel: NSObject {
    
    let signUpError: Box<String> = Box("")
    let signUpSuccess: Box<Bool> = Box(false)
    let isSignUpLoading: Box<Bool> = Box(false)
    
    fileprivate var currentNonce: String?
    
    var cancellables: Set<AnyCancellable> = []
    
    func signUp(name: String, email: String, password: String, passwordConfirmation: String) {
        isSignUpLoading.value = true
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                try? Auth.auth().signOut()
                self.isSignUpLoading.value = false
                self.signUpError.value = error.localizedDescription
                return
            }
            
            if let result = result {
                let changeRequest = result.user.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error = error {
                        try? Auth.auth().signOut()
                        self.isSignUpLoading.value = false
                        self.signUpError.value = error.localizedDescription
                        return
                    }
                    
                    self.isSignUpLoading.value = false
                    self.signUpSuccess.value = true
                }
            } else {
                try? Auth.auth().signOut()
                self.isSignUpLoading.value = false
                self.signUpError.value = "Failed to sign up"
                return
            }
        }
    }
    
    func signInWithGoogle(viewController: UIViewController) {
        isSignUpLoading.value = true
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [unowned self] result, error in
            if let error = error {
                isSignUpLoading.value = false
                signUpError.value = error.localizedDescription
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                isSignUpLoading.value = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { [unowned self] result, error in
                if let error = error {
                    isSignUpLoading.value = false
                    signUpError.value = error.localizedDescription
                    return
                }
                
                isSignUpLoading.value = false
                signUpSuccess.value = true
            }
        }
    }
}

extension SignUpViewModel: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func signInWithApple(viewController: UIViewController) {
        isSignUpLoading.value = true
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            isSignUpLoading.value = false
            signUpError.value = "Unable to generate nonce. SecRandomCopyBytes with OSStatus \(errorCode)"
            fatalError("Unable to generate nonce. SecRandomCopyBytes with OSStatus \(errorCode)")
        }
        
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashData = SHA256.hash(data: inputData)
        let hashString = hashData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                isSignUpLoading.value = false
                signUpError.value = "No login request were sent"
                fatalError("Invalid state: A login callback was received. But no login request were sent")
            }
            
            guard let appleIdToken = appleIdCredential.identityToken else {
                signUpError.value = "Unable to fetch identity"
                isSignUpLoading.value = false
                return
            }
            
            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                signUpError.value = "Unable to fetch identity"
                isSignUpLoading.value = false
                return
            }
            
            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIdCredential.fullName
            )
            
            Auth.auth().signIn(with: credential) { [unowned self] result, error in
                if let error = error {
                    signUpError.value = error.localizedDescription
                    isSignUpLoading.value = false
                    return
                }
                
                isSignUpLoading.value = false
                signUpSuccess.value = true
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        isSignUpLoading.value = false
        signUpError.value = error.localizedDescription
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
