//
//  HydrospaceRepositoryProtocol.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation
import Combine

protocol HydrospaceRepositoryProtocol {
    func observeDeviceValue(id: String) -> AnyPublisher<DeviceModel?, Never>
    func observeDevicesValue(userId: String) -> AnyPublisher<[DeviceModel], Never>
}
