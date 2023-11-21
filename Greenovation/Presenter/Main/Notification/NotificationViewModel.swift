//
//  NotificationViewModel.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import Combine
import FirebaseAuth

final class NotificationViewModel {
    
    private let repository: NotificationRepositoryProtocol = NotificationRepository()
    private let deviceRepository: DevicesRepositoryProtocol = DevicesRepository()
    var notifications: [NotificationModel] = []
    var devices: [String] = []
    let fetchNotificationSuccess: Box<Bool> = Box(false)
    let fetchNotificationFailed: Box<String> = Box("")
    let fetchNotificationLoading: Box<Bool> = Box(false)
    var cancellable: Set<AnyCancellable> = []
    
    func getNotifications() {
        fetchNotificationLoading.value = true
        let usersId = Auth.auth().currentUser?.uid ?? ""
        deviceRepository.getDevices()
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    fetchNotifications()
                case .failure(let error):
                    fetchNotificationLoading.value = true
                    fetchNotificationFailed.value = error.localizedDescription
                }
            } receiveValue: { devices in
                print("Devices: \(devices)")
                devices.forEach { model in
                    if model.usersId == usersId {
                        self.devices.append(model.serial_number)
                    }
                }
            }
            .store(in: &cancellable)

    }
    
    private func fetchNotifications() {
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
            } receiveValue: { [unowned self] notifications in
                notifications.forEach { notification in
                    if !notification.device_id.isEmpty && devices.contains(notification.device_id) {
                        self.notifications = notifications
                    }
                }
            }
            .store(in: &cancellable)
    }
}
