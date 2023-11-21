//
//  RegisterFormulaViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 11/11/23.
//

import Foundation
import FirebaseAuth
import Combine

final class RegisterFormulaViewModel {
    
    var plant: PlantModel
    let successSaveFormula: Box<Bool> = Box(false)
    let errorSaveFormula = Box("")
    let loadingSaveFormula = Box(false)
    
    private var cancellables: Set<AnyCancellable> = []
    private let repository = PlantRepository()
    
    init(plant: PlantModel) {
        self.plant = plant
    }
    
    func saveFormula(
        anakanMinPh: String,
        anakanMaxPh: String,
        anakanMinPpm: String,
        anakanMaxPpm: String,
        vegetatifAwalMinPh: String,
        vegetatifAwalMaxPh: String,
        vegetatifAwalMinPpm: String,
        vegetatifAwalMaxPpm: String,
        vegetatifMenengahMinPh: String,
        vegetatifMenengahMaxPh: String,
        vegetatifMenengahMinPpm: String,
        vegetatifMenengahMaxPpm: String
    ) {
        loadingSaveFormula.value = true
        let userId = Auth.auth().currentUser?.uid ?? ""
        let body = PlantBody(
            name: plant.name,
            image_url: plant.image_url.isEmpty ? "image-plant-default" : plant.image_url,
            users_id: userId,
            phases: [
                .init(
                    step: "anakan",
                    min_ppm: anakanMinPpm.toDouble(),
                    max_ppm: anakanMaxPpm.toDouble(),
                    min_ph: anakanMinPh.toDouble(),
                    max_ph: anakanMaxPh.toDouble()
                ),
                .init(
                    step: "vegetatif_awal",
                    min_ppm: vegetatifAwalMinPpm.toDouble(),
                    max_ppm: vegetatifAwalMaxPpm.toDouble(),
                    min_ph: vegetatifAwalMinPh.toDouble(),
                    max_ph: vegetatifAwalMaxPh.toDouble()
                ),
                .init(
                    step: "vegetatif_menengah",
                    min_ppm: vegetatifMenengahMinPpm.toDouble(),
                    max_ppm: vegetatifMenengahMaxPpm.toDouble(),
                    min_ph: vegetatifMenengahMinPh.toDouble(),
                    max_ph: vegetatifMenengahMaxPh.toDouble()
                ),
            ]
        )
        
        print("Body: \(body)")
        
        repository.savePlant(body: body)
            .sink { [unowned self] completion in
                loadingSaveFormula.value = false
                switch completion {
                case .finished:
                    print("Finished Request")
                    successSaveFormula.value = true
                case .failure(let error):
                    print("Error: \(error)")
                    errorSaveFormula.value = error.localizedDescription
                }
            } receiveValue: { response in
                print("Response: \(response)")
            }
            .store(in: &cancellables)
    }
}

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
}
