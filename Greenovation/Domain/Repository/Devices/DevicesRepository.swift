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
    
    func getDevices() -> AnyPublisher<[DeviceModel], Error> {
        return api.getDevices()
            .map {
                return $0.map { [unowned self] response in
                    return self.mapResponseToDevice(response)
                }
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    private func mapResponseToDevice(_ response: DeviceResponse) -> DeviceModel {
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
                name: response.plant?.name ?? "",
                image_url: response.plant?.image_url ?? "",
                id: response.plant?.id ?? ""
            ),
            usersId: response.users_id ?? "",
            status: response.status ?? "",
            serial_number: response.serial_number ?? ""
        )
    }
}
