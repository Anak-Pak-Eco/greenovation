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
    let usersId: String
    let status: String
    let serial_number: String
    
    struct DevicePlantModel: Identifiable {
        let max_ph: Double
        let min_ph: Double
        let max_ppm: Double
        let min_ppm: Double
        let name: String
        let image_url: String
        let id: String
    }
}
