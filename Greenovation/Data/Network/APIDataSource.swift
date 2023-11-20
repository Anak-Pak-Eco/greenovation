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
    private let baseURL = "https://pak-eco.pat-pet.my.id"
//    private let baseURL = "http://10.60.61.244:8000"
    
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
    
    func savePlant(_ body: PlantBody) -> AnyPublisher<String, AFError> {
        return AF.request(baseURL + APIEndpoint.plants.rawValue, method: .post, parameters: body, encoder: JSONParameterEncoder.default)
            .publishString()
            .value()
            .map { response in
                return response
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func updatePlant(id: String, _ body: PlantBody) -> AnyPublisher<String, AFError> {
        return AF.request(baseURL + APIEndpoint.plants.rawValue + "/\(id)", method: .put, parameters: body, encoder: JSONParameterEncoder.default)
            .publishString()
            .value()
            .map { response in
                return response
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func deletePlant(id: String) -> AnyPublisher<String, AFError> {
        return AF.request(baseURL + APIEndpoint.plants.rawValue + "/\(id)", method: .delete)
            .publishString()
            .value()
            .map { response in
                return response
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func addDevice(_ body: DeviceBody) -> AnyPublisher<String, AFError> {
        return AF.request(baseURL + APIEndpoint.devices.rawValue + "/update", method: .post, parameters: body, encoder: JSONParameterEncoder.default)
            .publishString()
            .value()
            .map { response in
                return response
            }
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    func getDeviceHistories(_ deviceId: String) -> AnyPublisher<[DeviceHistoryResponse], AFError> {
        print("baseURL: \(baseURL + APIEndpoint.devices.rawValue + "/get-history/\(deviceId)")")
        return AF.request(baseURL + APIEndpoint.devices.rawValue + "/get-history/\(deviceId)", method: .get)
            .publishDecodable(type: BaseResponse<[DeviceHistoryResponse]>.self)
            .value()
            .map {
                print("\($0.data)")
                return $0.data
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    private enum APIEndpoint: String {
        case notifications = "/notifications"
        case plants = "/plants"
        case devices = "/devices"
    }
}

extension Encodable {
    func toDict() -> Data {
        let jsonEncoder = JSONEncoder()
        return try! jsonEncoder.encode(self)
    }
}
