//
//  DeviceStatusResponse.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceStatusResponse: Codable {
    static let reference = "devices"
    static let currentPhReference = "current_ph"
    static let currentStepsReference = "current_steps"
    static let currentPpmReference = "current_ppm"
    static let nameReference = "name"
    static let plantIdReference = "plant_id"
    static let userIdReference = "user_id"
    
    let currentPh: Double?
    let currentSteps: String?
    let currentPpm: Double?
    let name: String?
    let plantId: String?
    let userId: String?
    
    enum CodingKeys: String, CodingKey {
        case currentPh = "current_ph"
        case currentSteps = "current_steps"
        case currentPpm = "current_ppm"
        case name
        case plantId = "plant_id"
        case userId = "user_id"
    }
}
