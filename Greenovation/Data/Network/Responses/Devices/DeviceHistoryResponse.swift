//
//  DeviceHistoryResponse.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 20/11/23.
//

import Foundation

struct DeviceHistoryResponse: Codable {
    let current_ph: Int?
    let created_at: String?
    let serial_number: String?
    let current_ppm: Int?
}
