//
//  UIViewController+Extensions.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

extension UITextField {
    func setUnderLine(color: UIColor = UIColor.primaryAccent, width: Double = 1) {
        let border = CALayer()
        let width = CGFloat(width)
        border.borderColor = color.cgColor
        border.frame = CGRect(
            x: 0,
            y: self.frame.size.height - width,
            width: self.frame.size.width + 30,
            height: self.frame.size.height
        )
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
