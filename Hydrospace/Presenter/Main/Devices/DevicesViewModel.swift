//
//  DevicesViewModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI
import Combine

class DevicesViewModel: ObservableObject {
    
    @Published var deviceStatus: DeviceStatusModel? = nil
    @Published var isLoading: Bool = false
    private let repository = HydrospaceRepository.shared
    
    private var cancellables: Set<AnyCancellable> = []
    
    func initData() {
        self.isLoading = true
        repository.observeDeviceValue(id: "device_001")
            .sink { [weak self] deviceStatus in
                DispatchQueue.main.async {
                    self?.deviceStatus = deviceStatus
                    self?.isLoading = false
                }
            }
            .store(in: &cancellables)
    }
}
