//
//  ApiService.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import Foundation
import Alamofire
import Combine

class ApiService {
    static let shared = ApiService()
    
    func getAuthors() -> AnyPublisher<DataResponse<AuthorResponse, AFError>, Never> {
        let response = AF.request("https://poetrydb.org/author", method: .get)
            .validate()
            .publishDecodable(type: AuthorResponse.self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return response
    }
    
    func getTitles(author: String) -> AnyPublisher<DataResponse<[TitleResponse], AFError>, Never> {
        return AF.request("https://poetrydb.org/author/\(author)/title", method: .get)
            .validate()
            .publishDecodable(type: [TitleResponse].self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getPoetries(author: String, title: String) -> AnyPublisher<DataResponse<[PoetryDetailResponse], AFError>, Never> {
        return AF.request("https://poetrydb.org/author,title/\(author);\(title)")
            .validate()
            .publishDecodable(type: [PoetryDetailResponse].self)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
