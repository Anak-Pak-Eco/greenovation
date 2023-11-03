//
//  DevicesViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 25/10/23.
//

import Combine
import FirebaseMessaging

final class DevicesViewModel {
    
    let successGetDevices = Box(false)
    var devices: [DeviceModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let repository: HydrospaceRepositoryProtocol = HydrospaceRepository.shared
    
    func getDevices() {
        repository
            .observeDevicesValue()
            .sink { [weak self] model in
                guard let self = self else { return }
                self.devices = model
                self.successGetDevices.value = true
                model.forEach { device in
                    Messaging.messaging().subscribe(toTopic: device.id) { error in
                        if let error = error {
                            print("Error subscribing topic: \(error.localizedDescription)")
                        } else {
                            print("Success subscribing topic \(device.name)")
                        }
                    }
                }
            }
            .store(in: &cancellables)
    }
}
