//
//  PlantResponse.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Foundation

struct PlantResponse: Codable {
    let id: String?
    let image_url: String?
    let users_id: String?
    let phases: [PlantPhaseResponse]?
    let name: String?
    
    struct PlantPhaseResponse: Codable {
        let max_ppm: Double?
        let min_ppm: Double?
        let max_ph: Double?
        let min_ph: Double?
        let step: String?
    }
}
