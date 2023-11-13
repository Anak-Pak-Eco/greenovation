//
//  DetailDeviceViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import Foundation
import Combine

final class DetailDeviceViewModel {
    private let repository: HydrospaceRepositoryProtocol = HydrospaceRepository.shared
    private var cancellable: Set<AnyCancellable> = []
    
    var device: Box<DeviceModel?> = Box(nil)
    
    func observeDevice(deviceId: String) {
        repository.observeDeviceValue(id: deviceId)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.device.value = model
            }
            .store(in: &cancellable)
    }
}
