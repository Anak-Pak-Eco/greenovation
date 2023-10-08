//
//  DeviceStatusResponse.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceStatusResponse: Codable {
    let currentPh: Double?
    let currentSteps: String?
    let currentPpm: Double?
    let name: String?
    let plantId: String?
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case currentPh = "current_ph"
        case currentSteps = "current_steps"
        case currentPpm = "current_tds"
        case name
        case plantId = "plant_id"
        case userId = "user_id"
    }
}
