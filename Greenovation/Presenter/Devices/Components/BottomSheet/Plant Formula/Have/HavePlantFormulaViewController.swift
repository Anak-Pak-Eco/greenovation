//
//  HavePlantFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 08/11/23.
//

import UIKit

class HavePlantFormulaViewController: UIViewController {
    
    let plantName = String(localized: "caisim")
    let growthStep = String(localized: "fase-anakan")
    
    @IBOutlet var ppmLabel: LocalizableLabel!
    @IBOutlet var pHLabel: LocalizableLabel!
    
    @IBOutlet var dismissButton: UIImageView!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var ppmMin: UILabel!
    @IBOutlet var ppmMax: UILabel!
    @IBOutlet var phMin: UILabel!
    @IBOutlet var phMax: UILabel!
    @IBOutlet var saveButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
    }
    
    @objc func dismissButtonTapped() {
        print("Dismiss")
    }
    
    @objc func saveButtonTapped() {
        print("Save")
    }
    
    private func style() {
        // Save Button Tapped
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // Dismiss Button Tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonTapped))
        dismissButton.isUserInteractionEnabled = true
        dismissButton.addGestureRecognizer(tapGesture)
        
        // Label Bold
        descLabel.attributedText = String.getStringAttributed(from: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk \(plantName) pada \(growthStep)"), boldStrings: ["\(plantName)", "\(growthStep)"], regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!, boldTextStyle: UIFont(name: "DMSans-Bold", size: 12)!)
        descLabel.adjustsFontSizeToFitWidth = true
        
        // ppm Label
        ppmLabel.attributedText = String.getStringAttributed(from: String(localized: "ppm-level"), boldStrings: ["Nutrient Concentration", "Kepekatan Nutrisi"], regularTextStyle: UIFont(name: "DMSans-Regular", size: 15)!, boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 15)!)
        ppmLabel.adjustsFontSizeToFitWidth = true
        
        // pH Label
//        pHLabel.attributedText = String.getStringAttributed(from: String(localized: "tingkat-ph"), boldStrings: ["Tingkat pH", "pH Level"], boldTextStyle: UIFont(name: "DMSans-Bold", size: 15)!)
    }
    
}
