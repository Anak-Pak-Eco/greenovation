//
//  HydrospaceAPIDataSource.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 29/10/23.
//

import Foundation
import Alamofire
import Combine

final class APIDataSource {
    
    static let shared = APIDataSource()
//    private let baseURL = "https://pak-eco.pat-pet.my.id"
    private let baseURL = "http://10.60.32.15:8000"
    
    func getNotifications() -> AnyPublisher<[NotificationResponse], AFError> {
        return AF.request(baseURL + APIEndpoint.notifications.rawValue, method: .get)
            .validate()
            .publishDecodable(type: BaseResponse<[NotificationResponse]>.self)
            .value()
            .map { response in
                response.data
            }
            .eraseToAnyPublisher()
    }
    
    func getPlants(
        usersId: String?,
        userOnly: String?
    ) -> AnyPublisher<[PlantResponse], AFError> {
        
        var parameters: [String: Any] = [:]
        if let usersId = usersId {
            parameters.updateValue(usersId, forKey: "users_id")
        }
        
        if let userOnly = userOnly {
            parameters.updateValue(userOnly, forKey: "user_only")
        }
        
        return AF.request(baseURL + APIEndpoint.plants.rawValue, method: .get, parameters: parameters)
            .validate()
            .publishDecodable(type: BaseResponse<[PlantResponse]>.self)
            .value()
            .map { response in
                response.data
            }
            .eraseToAnyPublisher()
    }
    
    private enum APIEndpoint: String {
        case notifications = "/notifications"
        case plants = "/plants"
    }
}
