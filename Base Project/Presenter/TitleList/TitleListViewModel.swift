//
//  FeaturesBViewModel.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 30/09/23.
//

import Foundation
import Combine

class TitleListViewModel {
    
    let repository = PoetryRepository.shared
    
    let titles: Box<[TitleModel]> = Box([])
    let titlesLoading: Box<Bool> = Box(false)
    let titlesError = Box("")
    
    private var setCancellables: Set<AnyCancellable> = []
    
    func initData(author: String) {
        titlesLoading.value = true
        repository.getTitlesFromAuthor(author)
            .sink { [weak self] result in
                switch result {
                case .success(let titles):
                    self?.titles.value = titles
                case .failure(let error):
                    self?.titlesError.value = error.localizedDescription
                }
                
                self?.titlesLoading.value = false
            }
            .store(in: &setCancellables)
    }
}
