//
//  DeviceHistoryModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 20/11/23.
//

import Foundation

struct DeviceHistoryModel: Identifiable {
    let id = UUID()
    let current_ph: Int
    let created_at: Date
    let serial_number: String
    let current_ppm: Int
}
