//
//  HavePlantFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 08/11/23.
//

import UIKit

class HavePlantFormulaViewController: UIViewController {

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
    }
    
}
