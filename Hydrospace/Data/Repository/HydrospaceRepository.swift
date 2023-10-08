//
//  HydrospaceRepository.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation
import Combine

class HydrospaceRepository: HydrospaceRepositoryProtocol {
    
    private let hydrospaceDataSource = HydrospaceRTDBDataSource.shared
    static let shared = HydrospaceRepository()
    
    func observeDeviceValue(id: String) -> AnyPublisher<DeviceStatusModel?, Never> {
        return hydrospaceDataSource.getDeviceStatus(id: id)
            .map { response in
                if let response = response {
                    return DeviceStatusModel(
                        currentPh: response.currentPh ?? 0.0,
                        currentSteps: response.currentSteps ?? "",
                        currentPpm: response.currentPpm ?? 0.0,
                        name: response.name ?? "",
                        plantId: response.plantId ?? "",
                        userId: response.userId ?? ""
                    )
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
}
