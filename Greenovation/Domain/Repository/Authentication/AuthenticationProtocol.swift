//
//  AuthenticationProtocol.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 05/11/23.
//

import Combine
import FirebaseAuth

protocol AuthenticationProtocol {
    func signIn(email: String, password: String) -> AnyPublisher<AuthDataResult, Error>
}
