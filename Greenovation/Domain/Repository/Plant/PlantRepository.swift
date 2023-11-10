//
//  PlantRepository.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Combine

final class PlantRepository: PlantRepositoryProtocol {
    
    private let dataSource = APIDataSource.shared
    
    func getPlants(usersId: String? = nil, userOnly: String? = nil) -> AnyPublisher<[PlantModel], Error> {
        return dataSource.getPlants(usersId: usersId, userOnly: userOnly)
            .map {
                let plants = PlantModel.from($0)
                return plants
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
