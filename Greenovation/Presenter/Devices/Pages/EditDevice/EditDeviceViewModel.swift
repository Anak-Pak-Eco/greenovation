//
//  EditDeviceViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 21/11/23.
//

import Combine

final class EditDeviceViewModel {
    
    let loadingSaveDevice = Box(false)
    let errorSaveDevice: Box<Error?> = Box(nil)
    let successSaveDevice: Box<Bool> = Box(false)
    let successDeleteDevice: Box<Bool> = Box(false)
    private var cancellables: Set<AnyCancellable> = []
    private let repository: DevicesRepositoryProtocol = DevicesRepository()
    
    func saveDevice(device: DeviceModel, name: String, status: String) {
        loadingSaveDevice.value = true
        let body = DeviceBody(
            name: name,
            users_id: device.usersId,
            plants_id: device.plant.id,
            serial_number: device.id,
            current_phase: device.currentSteps,
            status: status
        )
        
        print("edit device body: \(body)")
        
        repository.saveDevice(body: body)
            .sink { [unowned self] completion in
                loadingSaveDevice.value = false
                switch completion {
                case .finished:
                    successSaveDevice.value = true
                case .failure(let error):
                    errorSaveDevice.value = error
                }
            } receiveValue: { response in
                print("edit device response: \(response)")
            }
            .store(in: &cancellables)
    }
    
    func deleteDevice(deviceId: String) {
        repository.deleteDevice(deviceId)
            .sink { [unowned self] completion in
                loadingSaveDevice.value = false
                switch completion {
                case .finished:
                    successDeleteDevice.value = true
                case .failure(let error):
                    errorSaveDevice.value = error
                }
            } receiveValue: { response in
                print("delete device response: \(response)")
            }
            .store(in: &cancellables)
    }
}
