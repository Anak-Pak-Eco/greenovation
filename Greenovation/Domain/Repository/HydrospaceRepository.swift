//
//  HydrospaceRepository.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation
import Combine

class HydrospaceRepository: HydrospaceRepositoryProtocol {
    
    private let hydrospaceDataSource = RTDBDataSource.shared
    static let shared: HydrospaceRepositoryProtocol = HydrospaceRepository()
    
    func observeDevicesValue() -> AnyPublisher<[DeviceModel], Never> {
        return hydrospaceDataSource.getDevicesStatus()
            .map { responses in
                return responses.map { response in
                    DeviceModel(
                        id: response.id ?? "",
                        currentPh: response.currentPh ?? 0,
                        currentSteps: response.currentSteps ?? "",
                        currentPpm: response.currentPpm ?? 0,
                        name: response.name ?? "",
                        plantId: response.plantId ?? "",
                        userId: response.userId ?? "",
                        deviceStatus: response.deviceStatus ?? ""
                    )
                }
            }
            .eraseToAnyPublisher()
    }
    
    func observeDeviceValue(id: String) -> AnyPublisher<DeviceModel?, Never> {
        return hydrospaceDataSource.getDeviceStatus(id: id)
            .map { response in
                if let response = response {
                    return DeviceModel(
                        id: response.id ?? "",
                        currentPh: response.currentPh ?? 0.0,
                        currentSteps: response.currentSteps ?? "",
                        currentPpm: response.currentPpm ?? 0.0,
                        name: response.name ?? "",
                        plantId: response.plantId ?? "",
                        userId: response.userId ?? "",
                        deviceStatus: response.deviceStatus ?? ""
                    )
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
}
