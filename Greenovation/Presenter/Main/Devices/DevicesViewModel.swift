//
//  DevicesViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 25/10/23.
//

import Combine

final class DevicesViewModel {
    
    let successGetDevices = Box(false)
    var devices: [DeviceModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let repository = HydrospaceRepository.shared
    
    func getDevices() {
        repository
            .observeDevicesValue()
            .sink { [weak self] model in
                guard let self = self else { return }
                self.devices = model
                self.successGetDevices.value = true
            }
            .store(in: &cancellables)
    }
}
