//
//  PoetryRepository.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 30/09/23.
//

import Foundation
import Combine

protocol PoetryProtocol {
    func getAuthors() -> AnyPublisher<AuthorModelResult, Never>
    func getTitlesFromAuthor(_ author: String) -> AnyPublisher<Result<[TitleModel], Error>, Never>
    func getPoetries(author: String, title: String) -> AnyPublisher<Result<[PoetryModel], Error>, Never>
}
