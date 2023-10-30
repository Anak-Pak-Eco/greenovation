//
//  GradientView.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import Foundation
import UIKit

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        gradientLayer.startPoint = .init(x: 0.5, y: 0)
        gradientLayer.endPoint   = .init(x: 0.5, y: 1)
    }
    
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 17.0, *) {
            let _ = UITraitCollection.current.changedTraits(from: previousTraitCollection)
        } else {
            super.traitCollectionDidChange(previousTraitCollection)
        }
        updatePoints()
        updateLocations()
        updateColors()
    }

}
