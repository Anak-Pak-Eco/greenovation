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
    var notifications: [NotificationModel] = []
    let fetchNotificationSuccess: Box<Bool> = Box(false)
    let fetchNotificationFailed: Box<String> = Box("")
    let fetchNotificationLoading: Box<Bool> = Box(false)
    var cancellable: Set<AnyCancellable> = []
    
    func getNotifications() {
        fetchNotificationLoading.value = true
        repository.getNotifications()
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.fetchNotificationLoading.value = false
                    self.fetchNotificationSuccess.value = true
                case .failure(let error):
                    self.fetchNotificationLoading.value = false
                    self.fetchNotificationFailed.value = error.localizedDescription
                }
            } receiveValue: { [weak self] notifications in
                guard let self = self else { return }
                self.notifications = notifications
            }
            .store(in: &cancellable)
    }
}
