//
//  PlantRepositoryProtocol.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 09/11/23.
//

import Combine

protocol PlantRepositoryProtocol {
    func getPlants(usersId: String?, userOnly: String?) -> AnyPublisher<[PlantModel], Error>
    func savePlant(body: PlantBody) -> AnyPublisher<String, Error>
    func updatePlant(id: String, body: PlantBody) -> AnyPublisher<String, Error>
    func deletePlant(id: String) -> AnyPublisher<String, Error>
}
