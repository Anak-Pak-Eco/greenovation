//
//  SignInViewModel.swift
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

final class SignInViewModel: NSObject {
    
    let signInError: Box<String> = Box("")
    let signInSuccess: Box<Bool> = Box(false)
    let isSignInLoading: Box<Bool> = Box(false)
    fileprivate var currentNonce: String?
    private let repository: AuthenticationProtocol = AuthenticationRepository()
    
    var cancellables: Set<AnyCancellable> = []
    
    func signIn(email: String, password: String) {
        isSignInLoading.value = true
        repository.signIn(email: email, password: password)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    isSignInLoading.value = false
                    signInSuccess.value = true
                case .failure(let error):
                    isSignInLoading.value = false
                    signInError.value = error.localizedDescription
                }
            } receiveValue: { result in
                print("Result: \(result.user)")
            }
            .store(in: &cancellables)
    }
    
    func signInWithGoogle(viewController: UIViewController) {
        isSignInLoading.value = true
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [unowned self] result, error in
            if let error = error {
                self.isSignInLoading.value = false
                self.signInError.value = error.localizedDescription
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                self.isSignInLoading.value = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString
            )
            
            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    self.isSignInLoading.value = false
                    self.signInError.value = error.localizedDescription
                    return
                }
                
                self.isSignInLoading.value = false
                self.signInSuccess.value = true
            }
        }
    }
}

extension SignInViewModel: ASAuthorizationControllerDelegate , ASAuthorizationControllerPresentationContextProviding {
    func signInWithApple(viewController: UIViewController) {
        // TODO: Move it to utils class
        func randomNonceString(length: Int = 32) -> String {
            precondition(length > 0)
            var randomBytes = [UInt8](repeating: 0, count: length)
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
            if errorCode != errSecSuccess {
                isSignInLoading.value = false
                signInError.value = "Unable to generate nonce. SecRandomCopyBytes with OSStatus \(errorCode)"
                fatalError("Unable to generate nonce. SecRandomCopyBytes with OSStatus \(errorCode)")
            }
            
            let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
            
            let nonce = randomBytes.map { byte in
                charset[Int(byte) % charset.count]
            }
            
            return String(nonce)
        }
        
        // TODO: Move it to utils class
        func sha256(_ input: String) -> String {
            let inputData = Data(input.utf8)
            let hashData = SHA256.hash(data: inputData)
            let hashString = hashData.compactMap {
                String(format: "%02x", $0)
            }.joined()
            
            return hashString
        }
        
        isSignInLoading.value = true
        
        currentNonce = randomNonceString()
        let appleIdProvider = ASAuthorizationAppleIDProvider()
        let request = appleIdProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(currentNonce ?? "")
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                isSignInLoading.value = false
                signInError.value = "No login request were sent"
                fatalError("Invalid state: A login callback was received. But no login request were sent")
            }
            
            guard let appleIdToken = appleIdCredential.identityToken else {
                signInError.value = "Unable to fetch identity"
                isSignInLoading.value = false
                return
            }
            
            guard let idTokenString = String(data: appleIdToken, encoding: .utf8) else {
                signInError.value = "Unable to fetch identity"
                isSignInLoading.value = false
                return
            }
            
            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIdCredential.fullName
            )
            
            Auth.auth().signIn(with: credential) { [unowned self] result, error in
                if let error = error {
                    signInError.value = error.localizedDescription
                    isSignInLoading.value = false
                    return
                }
                
                isSignInLoading.value = false
                signInSuccess.value = true
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        isSignInLoading.value = false
        signInError.value = error.localizedDescription
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        ASPresentationAnchor()
    }
}
