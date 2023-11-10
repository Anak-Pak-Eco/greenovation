//
//  AuthenticationDataSource.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 05/11/23.
//

import Foundation
import FirebaseAuth
import FirebaseAuthCombineSwift
import GoogleSignIn
import GoogleSignInSwift
import AuthenticationServices
import Combine

final class AuthDataSource {
    
    static let shared = AuthDataSource()
    
    func signIn(email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        return Auth.auth()
            .signIn(withEmail: email, password: password)
            .eraseToAnyPublisher()
    }
}
