//
//  DevicesRepository.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import Combine

final class DevicesRepository: DevicesRepositoryProtocol {
    
    private let api = APIDataSource()
    
    func saveDevice(body: DeviceBody) -> AnyPublisher<String, Error> {
        return api.addDevice(body)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
