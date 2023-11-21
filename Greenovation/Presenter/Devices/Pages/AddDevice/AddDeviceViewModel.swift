//
//  AddDeviceViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import Foundation
import FirebaseAuth
import Combine

final class AddDeviceViewModel {
    
    let loadingAddDevice = Box(false)
    let successFetchPlants = Box(false)
    let successAddDevice = Box(false)
    let errorFetchPlants = Box("")
    let updateSelectedPlant: Box<PlantModel?> = Box(nil)
    let updateSelectedPhase: Box<PlantModel.PlantPhaseModel?> = Box(nil)
    
    var plants: [PlantModel] = []
    var searchedPlants: [PlantModel] = []
    var selectedPlant: PlantModel? = nil
    var selectedPhase: PlantModel.PlantPhaseModel? = nil
    let serialNumber: String
    
    init(serialNumber: String) {
        self.serialNumber = serialNumber
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let repository: PlantRepositoryProtocol = PlantRepository()
    private let deviceRepository: DevicesRepositoryProtocol = DevicesRepository()
    
    func getPlants(query: String = "") {
        loadingAddDevice.value = true
        let userId = Auth.auth().currentUser?.uid ?? ""
        repository.getPlants(usersId: userId, userOnly: "true")
            .sink { [unowned self] completion in
                loadingAddDevice.value = false
                switch completion {
                case .finished:
                    successFetchPlants.value = true
                    if !query.isEmpty {
                        searchData(query: query)
                    }
                case .failure(let error):
                    errorFetchPlants.value = error.localizedDescription
                }
            } receiveValue: { [unowned self] plants in
                print("Plants: \(plants)")
                self.plants = plants
                self.searchedPlants = plants
            }
            .store(in: &cancellables)
    }
    
    func saveDevice(name: String) {
        loadingAddDevice.value = true
        let userId = Auth.auth().currentUser?.uid ?? ""
        let body = DeviceBody(
            name: name,
            users_id: userId,
            plants_id: selectedPlant?.id ?? "",
            serial_number: serialNumber,
            current_phase: selectedPhase?.step.rawValue ?? ""
        )
        
        deviceRepository.saveDevice(body: body)
            .sink { [unowned self] completion in
                loadingAddDevice.value = false
                switch completion {
                case .finished:
                    successAddDevice.value = true
                case .failure(let error):
                    errorFetchPlants.value = error.localizedDescription
                }
            } receiveValue: { response in
                print("Response add device: \(response)")
            }
            .store(in: &cancellables)
    }
    
    func searchData(query: String) {
        if query.isEmpty {
            searchedPlants = plants
        } else {
            searchedPlants = plants.filter { plant in
                plant.name.lowercased().contains(query.lowercased())
            }
        }
        successFetchPlants.value = true
    }
    
    func updateSelectedPlant(_ plant: PlantModel) {
        selectedPlant = plant
        updateSelectedPlant.value = plant
    }
    
    func updateSelectedPhase(_ phase: PlantModel.PlantPhaseModel) {
        selectedPhase = phase
        updateSelectedPhase.value = phase
    }
}
