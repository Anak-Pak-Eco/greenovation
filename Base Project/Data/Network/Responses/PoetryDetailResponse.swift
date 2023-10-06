//
//  PoetryDetailResponse.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 01/10/23.
//

import Foundation

struct PoetryDetailResponse: Codable {
    let title: String?
    let author: String?
    let lines: [String]?
    let linecount: String?
}
