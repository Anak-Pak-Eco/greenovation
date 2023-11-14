//
//  AddPlantBody.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 11/11/23.
//

import Foundation

struct PlantBody: Codable {
    let name: String?
    let image_url: String?
    let users_id: String?
    let phases: [Phases]?
    
    struct Phases: Codable {
        let step: String
        let min_ppm: Double
        let max_ppm: Double
        let min_ph: Double
        let max_ph: Double
    }
}
