//
//  NotificationViewModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import Combine

final class NotificationViewModel {
    
    private let repository: NotificationRepositoryProtocol = NotificationRepository()
    private var cancellable: Set<AnyCancellable> = []
    
    func getNotifications() {
        repository.getNotifications()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { notifications in
                print("Notifications: \(notifications)")
            }
            .store(in: &cancellable)

    }
}
