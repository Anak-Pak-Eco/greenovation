//
//  View+Extension.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 24/10/23.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.04
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
    }
}
