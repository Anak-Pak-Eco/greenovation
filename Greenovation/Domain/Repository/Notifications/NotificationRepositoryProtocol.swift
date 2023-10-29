//
//  NotificationProtocol.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 29/10/23.
//

import Combine

protocol NotificationRepositoryProtocol {
    func getNotifications() -> AnyPublisher<[NotificationModel], Error>
}
