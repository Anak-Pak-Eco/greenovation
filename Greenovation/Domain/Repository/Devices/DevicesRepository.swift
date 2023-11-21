//
//  DevicesRepository.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import Combine
import Foundation

final class DevicesRepository: DevicesRepositoryProtocol {
    
    private let api = APIDataSource()
    
    func saveDevice(body: DeviceBody) -> AnyPublisher<String, Error> {
        return api.addDevice(body)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func getDeviceHistory(_ deviceId: String) -> AnyPublisher<[DeviceHistoryModel], Error> {
        return api.getDeviceHistories(deviceId)
            .map {
                return $0.map { response in
                    let createdDate = ISO8601DateFormatter().date(from: response.created_at ?? "")
                    return DeviceHistoryModel(
                        current_ph: response.current_ph ?? 0,
                        created_at: createdDate ?? Date(),
                        serial_number: response.serial_number ?? "",
                        current_ppm: response.current_ppm ?? 0
                    )
                }
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    func deleteDevice(_ deviceId: String) -> AnyPublisher<String, Error> {
        return api.deleteDevice(deviceId)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
