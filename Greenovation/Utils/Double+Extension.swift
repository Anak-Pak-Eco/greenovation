//
//  Float+Extension.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 18/11/23.
//

import Foundation

extension Double {
    var clean: String {
        return self
            .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
