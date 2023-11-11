//
//  FormulaSettingViewModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Combine
import FirebaseAuth

final class FormulaSettingViewModel {
    
    private let repository = PlantRepository()
    var plants: [PlantModel] = []
    var searchedPlants: [PlantModel] = []
    let successGetPlants = Box(false)
    let loadingGetPlants = Box(false)
    let errorGetPlants = Box("")
    
    private var cancellables: Set<AnyCancellable> = []
    
    func getData() {
        loadingGetPlants.value = true
        let usersId = Auth.auth().currentUser?.uid ?? ""
        repository.getPlants(usersId: usersId, userOnly: "true")
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    loadingGetPlants.value = false
                    successGetPlants.value = true
                case .failure(let error):
                    loadingGetPlants.value = false
                    errorGetPlants.value = error.localizedDescription
                }
            } receiveValue: { [unowned self] plants in
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
        successGetPlants.value = true
    }
}
