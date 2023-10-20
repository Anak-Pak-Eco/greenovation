//
//  PendaftaranPerangkatModel.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 20/10/23.
//

import Foundation

class PendaftaranPerangkatModel: ObservableObject {
    @Published var plants: [Plant] = [
        Plant(name: "Caisim", imageName: "PlantImagePlaceholder"),
        Plant(name: "Bayam", imageName: "PlantImagePlaceholder"),
        Plant(name: "Kangkung", imageName: "PlantImagePlaceholder"),
        Plant(name: "Pakcoy", imageName: "PlantImagePlaceholder"),
    ]
    
    @Published var growthStages: [GrowthStage] = [
        GrowthStage(name: "fase-anakan", description: "Fase dimulai dari benih dan berlanjut dengan tanaman mulai mengembangkan daun sejati.", imageName: "growth-stage-placeholder"),
        GrowthStage(name: "fase-vegetatif-awal", description: "Tanaman mulai mempunyai akar yang kuat dan mengembangkan daun dan cabang.", imageName: "growth-stage-placeholder"),
        GrowthStage(name: "fase-vegetatif-menengah", description: "Tanaman mengalami pertumbuhan daun, batang, dan akar yang berlangsung dengan cepat hingga masa panen sayuran daun tiba.", imageName: "growth-stage-placeholder")
    ]
}

struct Plant: Identifiable {
    var id = UUID()
    var name: String
    var imageName: String
//    var ppmMin: Double
//    var ppmMax: Double
//    var phMin: Double
//    var phMax: Double
}

struct GrowthStage: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var imageName: String
}
