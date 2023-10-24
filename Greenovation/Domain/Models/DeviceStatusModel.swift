//
//  DeviceStatusModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceStatusModel: Identifiable {
    let id: UUID = UUID()
    let currentPh: Double
    let currentSteps: String
    let currentPpm: Double
    let name: String
    let plantId: String
    let userId: String
}
