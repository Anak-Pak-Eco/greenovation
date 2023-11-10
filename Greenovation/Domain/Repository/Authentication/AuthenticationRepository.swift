//
//  AuthenticationRepository.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 05/11/23.
//

import Combine
import FirebaseAuth

final class AuthenticationRepository: AuthenticationProtocol {
    
    private let dataSource = AuthDataSource.shared
    
    func signIn(email: String, password: String) -> AnyPublisher<AuthDataResult, Error> {
        return dataSource.signIn(email: email, password: password)
    }
}
