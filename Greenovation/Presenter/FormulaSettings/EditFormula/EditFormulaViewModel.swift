//
//  EditFormulaViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 11/11/23.
//

import Combine

final class EditFormulaViewModel {
    
    let successSaveFormula: Box<Bool> = Box(false)
    let deletedSaveFormula: Box<Bool> = Box(false)
    let errorSaveFormula = Box("")
    let loadingSaveFormula = Box(false)
    var plant: PlantModel
    var editMode = false
    
    private var cancellables: Set<AnyCancellable> = []
    private let repository = PlantRepository()
    
    init(plant: PlantModel) {
        self.plant = plant
    }
    
    func saveFormula(
        name: String,
        plantId: String,
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
        
        let body = PlantBody(
            name: name,
            image_url: nil,
            users_id: nil,
            phases: [
                .init(
                    step: PlantModel.PlantPhaseModel.Step.anakan.rawValue,
                    min_ppm: anakanMinPpm.toDouble(),
                    max_ppm: anakanMaxPpm.toDouble(),
                    min_ph: anakanMinPh.toDouble(),
                    max_ph: anakanMaxPh.toDouble()
                ),
                .init(
                    step: PlantModel.PlantPhaseModel.Step.vegetatif_awal.rawValue,
                    min_ppm: vegetatifAwalMinPpm.toDouble(),
                    max_ppm: vegetatifAwalMaxPpm.toDouble(),
                    min_ph: vegetatifAwalMinPh.toDouble(),
                    max_ph: vegetatifAwalMaxPh.toDouble()
                ),
                .init(
                    step: PlantModel.PlantPhaseModel.Step.vegetatif_menengah.rawValue,
                    min_ppm: vegetatifMenengahMinPpm.toDouble(),
                    max_ppm: vegetatifMenengahMaxPpm.toDouble(),
                    min_ph: vegetatifMenengahMinPh.toDouble(),
                    max_ph: vegetatifMenengahMaxPh.toDouble()
                ),
            ]
        )
        
        plant.phases = [
            .init(
                max_ppm: anakanMaxPpm.toDouble(),
                min_ppm: anakanMinPpm.toDouble(),
                max_ph: anakanMaxPh.toDouble(),
                min_ph: anakanMinPh.toDouble(),
                step: PlantModel.PlantPhaseModel.Step.anakan
            ),
            .init(
                max_ppm: vegetatifAwalMaxPpm.toDouble(),
                min_ppm: vegetatifAwalMinPpm.toDouble(),
                max_ph: vegetatifAwalMaxPh.toDouble(),
                min_ph: vegetatifAwalMinPh.toDouble(),
                step: PlantModel.PlantPhaseModel.Step.vegetatif_awal
            ),
            .init(
                max_ppm: vegetatifMenengahMaxPpm.toDouble(),
                min_ppm: vegetatifMenengahMinPpm.toDouble(),
                max_ph: vegetatifMenengahMaxPh.toDouble(),
                min_ph: vegetatifMenengahMinPh.toDouble(),
                step: PlantModel.PlantPhaseModel.Step.vegetatif_menengah
            )
        ]
        
        repository.updatePlant(id: plantId, body: body)
            .sink { [unowned self] completion in
                loadingSaveFormula.value = false
                switch completion {
                case .finished:
                    successSaveFormula.value = true
                case .failure(let error):
                    errorSaveFormula.value = error.localizedDescription
                }
            } receiveValue: { response in
                print("Response: \(response)")
            }
            .store(in: &cancellables)
    }
    
    func deletePlant(id: String) {
        loadingSaveFormula.value = true
        repository.deletePlant(id: id)
            .sink { [unowned self] completion in
                loadingSaveFormula.value = false
                switch completion {
                case .finished:
                    deletedSaveFormula.value = true
                case .failure(let error):
                    errorSaveFormula.value = error.localizedDescription
                }
            } receiveValue: { response in
                print("Response: \(response)")
            }
            .store(in: &cancellables)
    }
}
