//
//  MyChoiceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 09/11/23.
//

import UIKit

class MyChoiceViewController: UIViewController {
    
    @IBOutlet var whiteBackground: UIView!
    @IBOutlet var secondaryBackground: UIView!
    @IBOutlet var ppmLabel: LocalizableLabel!
    @IBOutlet var ppmMin: UILabel!
    @IBOutlet var ppmMax: UILabel!
    @IBOutlet var phMin: UILabel!
    @IBOutlet var phMax: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
    }
    
    private func style() {
        // ppm Label
        ppmLabel.attributedText = String.getStringAttributed(from: String(localized: "kepekatan-nutrisi"), boldStrings: ["Nutrient Concentration", "Kepekatan Nutrisi"], regularTextStyle: UIFont(name: "DMSans-Regular", size: 15)!, boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 15)!)
        ppmLabel.adjustsFontSizeToFitWidth = true
        
        // White Background
        whiteBackground.layer.cornerRadius = 8.0
        whiteBackground.clipsToBounds = true
        whiteBackground.layer.shadowColor = UIColor.black.cgColor
        whiteBackground.layer.shadowOpacity = 0.04
        whiteBackground.layer.shadowOffset = CGSize(width: 0, height: 3)
        whiteBackground.layer.shadowRadius = 12
        
        // Secondary Background
        secondaryBackground.layer.cornerRadius = 8.0
        secondaryBackground.clipsToBounds = true
    }
    
}
