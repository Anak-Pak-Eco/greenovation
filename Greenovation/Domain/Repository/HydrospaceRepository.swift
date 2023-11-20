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
    
    func observeDevicesValue(userId: String) -> AnyPublisher<[DeviceModel], Never> {
        return hydrospaceDataSource.getDevices(userId: userId)
            .map { responses in
                return responses.map { response in
                    return self.mapResponseToDevice(response)
                }
            }
            .eraseToAnyPublisher()
    }
    
    func observeDeviceValue(id: String) -> AnyPublisher<DeviceModel?, Never> {
        return hydrospaceDataSource.getDeviceStatus(id: id)
            .map { response in
                if let response = response {
                    print("Response: \(response)")
                    return self.mapResponseToDevice(response)
                } else {
                    return nil
                }
            }
            .eraseToAnyPublisher()
    }
    
    func mapResponseToDevice(_ response: DeviceResponse) -> DeviceModel {
        return DeviceModel(
            id: response.id ?? "",
            name: response.name ?? "",
            currentPh: response.current_ph ?? 0,
            currentSteps: response.current_steps ?? "",
            currentPpm: response.current_ppm ?? 0,
            plant: DeviceModel.DevicePlantModel(
                max_ph: response.plant?.max_ph ?? 0,
                min_ph: response.plant?.min_ph ?? 0,
                max_ppm: response.plant?.max_ppm ?? 0,
                min_ppm: response.plant?.min_ppm ?? 0,
                name: response.plant?.name ?? ""
            ),
            phase: DeviceModel.DevicePhaseModel(
                max_ph: response.phase?.max_ph ?? 0,
                min_ph: response.phase?.min_ph ?? 0,
                max_ppm: response.phase?.max_ppm ?? 0,
                min_ppm: response.phase?.min_ppm ?? 0,
                step: response.phase?.step ?? ""
            ),
            usersId: response.users_id ?? "",
            status: response.status ?? ""
        )
    }
}
