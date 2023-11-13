//
//  DontHavePlantFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 08/11/23.
//

import UIKit

class DontHavePlantFormulaViewController: UIViewController {
    
    private var isDisabled = false
    private var plantName = String(localized: "caisim")
    private var growthStep = String(localized: "fase-anakan")
    private var ppm = "1300 - 1500"
    private var ph = "6,0 - 7,0"

    @IBOutlet var ppmLabel: UILabel!
    
    @IBOutlet var dismissButton: UIImageView!
    @IBOutlet var ppmMin: UITextField!
    @IBOutlet var ppmMax: UITextField!
    @IBOutlet var phMin: UITextField!
    @IBOutlet var phMax: UITextField!
    @IBOutlet var formulaDesc: LocalizableLabel!
    @IBOutlet var saveButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
    }
    
    @objc func dismissButtonTapped() {
        print("Dismiss")
    }
    
    @objc func saveButtonTapped() {
        print("Saved")
    }
    
    @objc func textFieldEditingChanged() {
        updateSaveButtonState()
    }
    
    private func style() {
        // Field IsChange
        ppmMin.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        ppmMax.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        phMin.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        phMax.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        // Label Placeholder
        ppmMin.placeholder = NSLocalizedString(String(localized: "Min"), comment: "TextField placeholder")
        ppmMax.placeholder = NSLocalizedString(String(localized: "Max"), comment: "TextField placeholder")
        phMin.placeholder = NSLocalizedString(String(localized: "Min"), comment: "TextField placeholder")
        phMax.placeholder = NSLocalizedString(String(localized: "Max"), comment: "TextField placeholder")
        
        // Label Border
        ppmMin.layer.cornerRadius = 6.0
        ppmMin.layer.borderWidth = 1.0
        ppmMin.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMax.layer.cornerRadius = 6.0
        ppmMax.layer.borderWidth = 1.0
        ppmMax.layer.borderColor = UIColor.primaryAccent.cgColor
        phMin.layer.cornerRadius = 6.0
        phMin.layer.borderWidth = 1.0
        phMin.layer.borderColor = UIColor.primaryAccent.cgColor
        phMax.layer.cornerRadius = 6.0
        phMax.layer.borderWidth = 1.0
        phMax.layer.borderColor = UIColor.primaryAccent.cgColor
        
        // Label Bold
        ppmLabel.attributedText = String.getStringAttributed(from: String(localized: "ppm-level"), boldStrings: ["Nutrient Concentration", "Kepekatan Nutrisi"], regularTextStyle: UIFont(name: "DMSans-Regular", size: 15)!, boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 15)!)
        ppmLabel.adjustsFontSizeToFitWidth = true
        formulaDesc.attributedText = String.getStringAttributed(from: String(localized: "Rekomendasi yang diberikan Greenovation untuk \(plantName) pada \(growthStep) adalah Kepekatan Nutrisi: \(ppm)ppm dan Tingkat pH: \(ph)"), boldStrings: ["Greenovation", plantName, growthStep, "Kepekatan Nutrisi: \(ppm)ppm", "Nutrient Concentration: \(ppm)ppm", "Tingkat pH: \(ph)", "pH Level: \(ph)"], regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!, boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!)
        
        // Save Button
        if ppmMin.text == "" && ppmMax.text == "" && phMin.text == "" && phMax.text == "" {
            saveButton.tintColor = .surfaceContainerHighest
            saveButton.isUserInteractionEnabled = false
        }
        saveButton.layer.cornerRadius = 10.0
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // Dismiss Button
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissButtonTapped))
        dismissButton.isUserInteractionEnabled = true
        dismissButton.addGestureRecognizer(tapGesture)
    }
    
    private func updateSaveButtonState() {
        let isPpmMinEmpty = ppmMin.text?.isEmpty ?? true
        let isPpmMaxEmpty = ppmMax.text?.isEmpty ?? true
        let isPhMinEmpty = phMin.text?.isEmpty ?? true
        let isPhMaxEmpty = phMax.text?.isEmpty ?? true

        saveButton.isEnabled = !(isPpmMinEmpty && isPpmMaxEmpty && isPhMinEmpty && isPhMaxEmpty)
        saveButton.tintColor = saveButton.isEnabled ? .primaryAccent : .surfaceContainerHighest
        saveButton.isUserInteractionEnabled = saveButton.isEnabled
    }
    
}
