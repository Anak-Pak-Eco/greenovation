//
//  BaseResponse.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let message: String?
    let status_code: Int?
    let data: T
}
