//
//  NotificationRepository.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 29/10/23.
//

import Combine
import Foundation

final class NotificationRepository: NotificationRepositoryProtocol {
    
    private let dataSource = HydrospaceAPIDataSource.shared
    
    func getNotifications() -> AnyPublisher<[NotificationModel], Error> {
        return dataSource.getNotifications()
            .map { notifications in
                let notifications = notifications.map { response in
                    let createdDate = ISO8601DateFormatter().date(from: response.created_date ?? "")
                    return NotificationModel(
                        id: response.id ?? "",
                        device_id: response.device_id ?? "",
                        registration_token: response.registration_token ?? "",
                        action: response.action ?? "",
                        created_date: createdDate ?? Date(),
                        title: response.title ?? "",
                        body: response.body ?? ""
                    )
                }
                return notifications
            }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
