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
    let errorFetchPlants = Box("")
    var plants: [PlantModel] = []
    var searchedPlants: [PlantModel] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let repository: PlantRepositoryProtocol = PlantRepository()
    
    func getPlants() {
        loadingAddDevice.value = true
        let userId = Auth.auth().currentUser?.uid ?? ""
        repository.getPlants(usersId: userId, userOnly: "true")
            .sink { [unowned self] completion in
                loadingAddDevice.value = false
                switch completion {
                case .finished:
                    successFetchPlants.value = true
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
}
