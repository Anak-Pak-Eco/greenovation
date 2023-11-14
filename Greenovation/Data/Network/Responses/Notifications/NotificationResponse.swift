//
//  NotificationResponse.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 29/10/23.
//

import Foundation

struct NotificationResponse: Codable {
    let id: String?
    let device_id: String?
    let registration_token: String?
    let action: String?
    let created_date: String?
    let title: String?
    let body: String?
}
