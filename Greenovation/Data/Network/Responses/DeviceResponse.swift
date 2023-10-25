//
//  DeviceStatusResponse.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceResponse: Codable {
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
        case plantId = "plants_id"
        case userId = "users_id"
    }
    
    static let reference = "devices"
    static let currentPhReference = "current_ph"
    static let currentStepsReference = "current_steps"
    static let currentPpmReference = "current_ppm"
    static let nameReference = "name"
    static let plantIdReference = "plants_id"
    static let userIdReference = "users_id"
    
    static func from(response: NSDictionary) -> DeviceResponse {
        return DeviceResponse(
            currentPh: response[currentPhReference] as? Double ?? 0.0,
            currentSteps: response[currentStepsReference] as? String ?? "",
            currentPpm: response[currentPpmReference] as? Double ?? 0.0,
            name: response[nameReference] as? String ?? "",
            plantId: response[plantIdReference] as? String ?? "",
            userId: response[userIdReference] as? String ?? ""
        )
    }
}
