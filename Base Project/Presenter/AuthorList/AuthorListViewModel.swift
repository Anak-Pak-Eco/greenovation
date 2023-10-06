//
//  FeaturesAViewModel.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 30/09/23.
//

import Foundation
import Combine

class AuthorListViewModel {
    
    private let repository = PoetryRepository.shared
    let authorsLoading = Box(false)
    let authors: Box<[AuthorModel]> = Box([])
    let authorsError: Box<String?> = Box(nil)
    var filteredAuthors: [AuthorModel] = []
    
    private var setCancellables: Set<AnyCancellable> = []
    
    func initData() {
        authorsLoading.value = true
        repository.getAuthors()
            .sink { [weak self] result in
                switch result {
                case .success(let authors):
                    self?.filteredAuthors = authors
                    self?.authors.value = authors
                case .failure(let error):
                    self?.authorsError.value = error.localizedDescription
                }
                
                self?.authorsLoading.value = false
            }
            .store(in: &setCancellables)
    }
    
    func searchAuthors(query: String) {
        if query.isEmpty {
            self.filteredAuthors = authors.value
        } else {
            self.filteredAuthors = authors.value.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}
