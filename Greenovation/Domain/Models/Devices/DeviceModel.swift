//
//  DeviceStatusModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceModel: Identifiable {
    let id: String
    let name: String
    let currentPh: Double
    let currentSteps: String
    let currentPpm: Double
    let plant: DevicePlantModel
    let phase: DevicePhaseModel
    let usersId: String
    let status: String
    
    struct DevicePhaseModel {
        let max_ph: Double
        let min_ph: Double
        let max_ppm: Double
        let min_ppm: Double
        let step: String
    }
    
    struct DevicePlantModel {
        let max_ph: Double
        let min_ph: Double
        let max_ppm: Double
        let min_ppm: Double
        let name: String
    }
}
