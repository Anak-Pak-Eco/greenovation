//
//  DetailDeviceViewModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI
import Combine

class DetailDeviceViewModel: ObservableObject {
    
    @Published var deviceStatus: DeviceModel? = nil
    @Published var isLoading: Bool = false
    @Published var ml = "100ml"
    @Published var range = "800-1200"
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
