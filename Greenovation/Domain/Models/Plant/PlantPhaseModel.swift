//
//  PlantPhaseModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Foundation

struct PlantPhaseModel {
    let max_ppm: Double
    let min_ppm: Double
    let max_ph: Double
    let min_ph: Double
    let step: String
    
    static func from(_ response: [PlantPhaseResponse]?) -> [PlantPhaseModel] {
        guard let response = response else {
            return []
        }
        
        return response.map { phase in
            PlantPhaseModel(
                max_ppm: phase.max_ppm ?? 0,
                min_ppm: phase.min_ppm ?? 0,
                max_ph: phase.max_ph ?? 0,
                min_ph: phase.min_ph ?? 0,
                step: phase.step ?? ""
            )
        }
    }
}
