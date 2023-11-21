//
//  DeviceStatusResponse.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation

struct DeviceResponse: Codable {
    let id: String?
    let current_ph: Double?
    let current_steps: String?
    let current_ppm: Double?
    let name: String?
    let status: String?
    let users_id: String?
    let plant: DevicePlantResponse?
    let serial_number: String?
    
    struct DevicePlantResponse: Codable {
        let max_ph: Double?
        let min_ph: Double?
        let max_ppm: Double?
        let min_ppm: Double?
        let name: String?
        let image_url: String?
        let id: String?
        
        static let reference = "plant"
        
        static func from(response: NSDictionary?) -> DevicePlantResponse {
            return DevicePlantResponse(
                max_ph: response?[DeviceResponse.maxPhReference] as? Double,
                min_ph: response?[DeviceResponse.minPhReference] as? Double,
                max_ppm: response?[DeviceResponse.maxPpmReference] as? Double,
                min_ppm: response?[DeviceResponse.minPpmReference] as? Double,
                name: response?[DeviceResponse.nameReference] as? String,
                image_url: response?[DeviceResponse.imageUrlReference] as? String,
                id: response?[DeviceResponse.idReference] as? String
            )
        }
    }
}

// MARK: Realtime Database Setup
extension DeviceResponse {
    static let reference = "devices"
    static let idReference = "id"
    static let usersIdReference = "users_id"
    static let currentPhReference = "current_ph"
    static let currentStepsReference = "current_steps"
    static let currentPpmReference = "current_ppm"
    static let nameReference = "name"
    static let imageUrlReference = "image_url"
    static let phaseReference = "phase"
    static let stepReference = "step"
    static let deviceStatusReference = "status"
    static let maxPhReference = "max_ph"
    static let minPhReference = "min_ph"
    static let maxPpmReference = "max_ppm"
    static let minPpmReference = "min_ppm"
    
    static func from(response: NSDictionary, id: String) -> DeviceResponse {
        return DeviceResponse(
            id: id,
            current_ph: response[DeviceResponse.currentPhReference] as? Double,
            current_steps: response[DeviceResponse.currentStepsReference] as? String,
            current_ppm: response[DeviceResponse.currentPpmReference] as? Double,
            name: response[DeviceResponse.nameReference] as? String,
            status: response[DeviceResponse.deviceStatusReference] as? String,
            users_id: response[DeviceResponse.usersIdReference] as? String,
            plant: DevicePlantResponse.from(response: response[DevicePlantResponse.reference] as? NSDictionary),
            serial_number: nil
        )
    }
}
