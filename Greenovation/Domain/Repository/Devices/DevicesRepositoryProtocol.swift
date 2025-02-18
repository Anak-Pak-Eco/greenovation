//
//  DevicesRepositoryProtocol.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import Combine

protocol DevicesRepositoryProtocol {
    func getDevices() -> AnyPublisher<[DeviceModel], Error>
    func saveDevice(body: DeviceBody) -> AnyPublisher<String, Error>
    func getDeviceHistory(_ deviceId: String) -> AnyPublisher<[DeviceHistoryModel], Error>
    func deleteDevice(_ deviceId: String) -> AnyPublisher<String, Error>
}
