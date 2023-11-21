//
//  DeviceBody.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import Foundation

struct DeviceBody: Codable {
    let name: String
    let users_id: String
    let plants_id: String
    let serial_number: String
    let current_phase: String
    let status: String?
    
    init(name: String, users_id: String, plants_id: String, serial_number: String, current_phase: String, status: String? = nil) {
        self.name = name
        self.users_id = users_id
        self.plants_id = plants_id
        self.serial_number = serial_number
        self.current_phase = current_phase
        self.status = status
    }
}
