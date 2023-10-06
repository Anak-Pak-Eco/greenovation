//
//  PoetryRepository.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 30/09/23.
//

import Foundation
import Combine

typealias AuthorModelResult = Result<[AuthorModel], Error>

class PoetryRepository : PoetryProtocol {
    
    private let apiService = ApiService.shared
    static let shared = PoetryRepository()
    
    func getAuthors() -> AnyPublisher<AuthorModelResult, Never> {
        return apiService.getAuthors()
            .map { response in
                switch response.result {
                case .success(let response):
                    let authors = (response.authors ?? []).map { author in
                        AuthorModel(name: author)
                    }
                    return .success(authors)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getTitlesFromAuthor(_ author: String) -> AnyPublisher<Result<[TitleModel], Error>, Never> {
        return apiService.getTitles(author: author)
            .map { response in
                switch response.result {
                case .success(let titlesResponse):
                    let titles = titlesResponse.map { TitleModel(title: $0.title) }
                    return .success(titles)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getPoetries(author: String, title: String) -> AnyPublisher<Result<[PoetryModel], Error>, Never> {
        return apiService.getPoetries(author: author, title: title)
            .map { response in
                switch response.result {
                case .success(let poetriesResponse):
                    let poetries = poetriesResponse.map { response in
                        PoetryModel(
                            title: response.title ?? "",
                            author: response.author ?? "",
                            lines: response.lines ?? [],
                            lineCount: response.linecount ?? ""
                        )
                    }
                    return .success(poetries)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
