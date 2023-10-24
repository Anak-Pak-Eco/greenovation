//
//  String+Extension.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 20/10/23.
//

import Foundation

extension String {
    static func formatNullable(_ text: String?, format: String) -> String {
        guard let text = text else { return "" }
        return String(format: format, text)
    }
    
    static func formatNullable(_ text: Int?, format: String) -> String {
        guard let text = text else { return "" }
        return String(format: format, text)
    }
    
    static func formatNullable(_ text: Double?, format: String) -> String {
        guard let text = text else { return "" }
        return String(format: format, text)
    }
    
    static func format(_ text: String, format: String) -> String {
        return String(format: format, text)
    }
    
    static func format(_ text: Int, format: String) -> String {
        return String(format: format, text)
    }
    
    static func format(_ text: Double, format: String) -> String {
        return String(format: format, text)
    }
}
