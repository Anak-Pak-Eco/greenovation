//
//  DetailDeviceViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import Foundation
import UIKit
import Combine

final class DetailDeviceViewModel {
    
    private let repository: HydrospaceRepositoryProtocol = HydrospaceRepository.shared
    private let deviceRepository: DevicesRepositoryProtocol = DevicesRepository()
    private var cancellable: Set<AnyCancellable> = []
    private var anotherCancellables: Set<AnyCancellable> = []
    
    var deviceHistories: [DeviceHistoryModel] = []
    var alerts: [Alert] = []
    let deviceHistoryFetchSuccess = Box(false)
    let device: Box<DeviceModel?> = Box(nil)
    
    func observeDevice(deviceId: String) {
        repository.observeDeviceValue(id: deviceId)
            .sink { [unowned self] model in
                alerts.removeAll()
                if let model = model {
                    if model.currentPpm < model.plant.min_ppm {
                        let valueToAdd = (5 * (200 - model.currentPpm)) / 1000
                        alerts.append(
                            Alert(
                                type: .ppm,
                                title: String.getStringAttributed(
                                    from: String(localized: "low-ppm-alert-title"),
                                    boldStrings: [String(localized: "low-ppm-alert-title")],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                ),
                                message: String.getStringAttributed(
                                    from: String(localized: "low-ppm-description \(valueToAdd.clean)"),
                                    boldStrings: ["\(valueToAdd.clean)ml"],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                )
                            )
                        )
                    } else {
                        alerts.append(
                            Alert(
                                type: .ppm,
                                title: String.getStringAttributed(
                                    from: String(localized: "high-ppm-alert-title"),
                                    boldStrings: [String(localized: "high-ppm-alert-title")],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                ),
                                message: String.getStringAttributed(
                                    from: String(localized: "high-ppm-alert-description"),
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                )
                            )
                        )
                    }
                    
                    if model.currentPh < model.plant.min_ph {
                        let valueToAdd = (0.7692 * 1) - (0.6 * model.currentPh) + (0.3 * 400)
                        alerts.append(
                            Alert(
                                type: .ph,
                                title: String.getStringAttributed(
                                    from: String(localized: "low-ph-alert-title"),
                                    boldStrings: [String(localized: "low-ph-alert-title")],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                ),
                                message: String.getStringAttributed(
                                    from: String(localized: "low-ph-alert-description \(valueToAdd.clean)"),
                                    boldStrings: ["pH", "UP", "\(valueToAdd.clean)ml"],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                )
                            )
                        )
                    } else if model.currentPh > model.plant.max_ph {
                        let valueToAdd = (0.0925 * 1) - (0.02 * model.currentPh) + (0.25 * 200)
                        alerts.append(
                            Alert(
                                type: .ph,
                                title: String.getStringAttributed(
                                    from: String(localized: "high-ph-alert-title"),
                                    boldStrings: [String(localized: "high-ph-alert-title")],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                ),
                                message: String.getStringAttributed(
                                    from: String(localized: "high-ph-alert-description \(valueToAdd.clean)"),
                                    boldStrings: ["\(valueToAdd.clean)ml", "pH", "UP"],
                                    regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
                                    boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!
                                )
                            )
                        )
                    }
                }
                
                device.value = model
            }
            .store(in: &cancellable)
    }
    
    func onDeleteAlert(type: AlertType) {
        alerts.removeAll(where: { $0.type == type })
        deviceHistoryFetchSuccess.value = true
    }
    
    func getHistories(deviceId: String) {
        deviceRepository.getDeviceHistory(deviceId)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    deviceHistoryFetchSuccess.value = true
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [unowned self] devices in
                deviceHistories = devices
            }
            .store(in: &anotherCancellables)
    }
}

struct Alert {
    let type: AlertType
    let title: NSMutableAttributedString
    let message: NSMutableAttributedString
}

enum AlertType {
    case ph, ppm
}
