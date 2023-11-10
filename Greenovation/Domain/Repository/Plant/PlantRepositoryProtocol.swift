//
//  PlantRepositoryProtocol.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Combine

protocol PlantRepositoryProtocol {
    func getPlants(usersId: String?, userOnly: String?) -> AnyPublisher<[PlantModel], Error>
}
