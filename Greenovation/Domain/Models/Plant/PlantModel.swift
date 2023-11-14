//
//  PlantModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Foundation

struct PlantModel: Identifiable {
    let id: String
    let image_url: String
    let users_id: String
    let phases: [PlantPhaseModel]
    let name: String
    
    struct PlantPhaseModel {
        let max_ppm: Double
        let min_ppm: Double
        let max_ph: Double
        let min_ph: Double
        let step: Step
        
        static func from(_ response: [PlantResponse.PlantPhaseResponse]?) -> [PlantPhaseModel] {
            guard let response = response else {
                return []
            }
            
            return response.map { phase in
                PlantPhaseModel(
                    max_ppm: phase.max_ppm ?? 0,
                    min_ppm: phase.min_ppm ?? 0,
                    max_ph: phase.max_ph ?? 0,
                    min_ph: phase.min_ph ?? 0,
                    step: Step(rawValue: phase.step ?? "anakan") ?? .anakan
                )
            }
        }
        
        enum Step: String {
            case anakan, vegetatif_awal, vegetatif_menengah
            
            func getText() -> String {
                switch self {
                case .anakan:
                    return "Anakan"
                case .vegetatif_awal:
                    return "Vegetatif Awal"
                case .vegetatif_menengah:
                    return "Vegetatif Menengah"
                }
            }
        }
    }
    
    static func from(_ response: [PlantResponse]) -> [PlantModel] {
        return response.map {
            PlantModel(
                id: $0.id ?? "",
                image_url: $0.image_url ?? "",
                users_id: $0.users_id ?? "",
                phases: PlantPhaseModel.from($0.phases),
                name: $0.name ?? ""
            )
        }
    }
}
