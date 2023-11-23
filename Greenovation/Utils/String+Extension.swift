//
//  String+Extension.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 20/10/23.
//

import Foundation
import UIKit

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


extension String {
    static func getStringAttributed(
        from: String,
        boldStrings: [String] = [],
        regularTextStyle: UIFont = UIFont(name: "DMSans-Regular", size: 11)!,
        boldTextStyle: UIFont = UIFont(name: "DMSans-Bold", size: 11)!,
        textColor: UIColor = .onPrimaryContainer
    ) -> NSMutableAttributedString {
        let text = from as NSString
        let attrString = NSMutableAttributedString(
            string: text as String,
            attributes: [
                .font: regularTextStyle,
                .foregroundColor: textColor
            ]
        )
        
        boldStrings.forEach { boldString in
            attrString.addAttribute(
                .font, 
                value: boldTextStyle,
                range: text.range(of: boldString)
            )
        }
        
        return attrString
    }
}
