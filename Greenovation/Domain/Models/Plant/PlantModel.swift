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
