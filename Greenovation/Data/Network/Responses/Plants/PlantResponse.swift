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
}
