//
//  PoetryDetailViewModel.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 01/10/23.
//

import Foundation
import Combine

class PoetryDetailViewModel {
    
    private let repository = PoetryRepository.shared
    let poetries: Box<[PoetryModel]> = Box([])
    let poetriesLoading: Box<Bool> = Box(false)
    let poetriesError: Box<String> = Box("")
    
    var cancellables: Set<AnyCancellable> = []
    
    func initData(author: String, title: String) {
        poetriesLoading.value = true
        repository.getPoetries(author: author, title: title)
            .sink { [weak self] result in
                switch result {
                case .success(let poetries):
                    self?.poetries.value = poetries
                case .failure(let error):
                    self?.poetriesError.value = error.localizedDescription
                }
                
                self?.poetriesLoading.value = false
            }
            .store(in: &cancellables)
    }
}
