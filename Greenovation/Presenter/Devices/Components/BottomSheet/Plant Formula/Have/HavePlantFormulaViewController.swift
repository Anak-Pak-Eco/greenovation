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
    
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var ppmMin: UILabel!
    @IBOutlet var ppmMax: UILabel!
    @IBOutlet var phMin: UILabel!
    @IBOutlet var phMax: UILabel!
    @IBOutlet var saveButton: LocalizableButton!
    
    var plant: PlantModel
    var phase: PlantModel.PlantPhaseModel
    
    init(plant: PlantModel, phase: PlantModel.PlantPhaseModel) {
        self.plant = plant
        self.phase = phase
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(plant: .init(id: "", image_url: "", users_id: "", phases: [], name: ""), phase: .init(max_ppm: 0, min_ppm: 0, max_ph: 0, min_ph: 0, step: .anakan))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        descLabel.attributedText = String.getStringAttributed(
            from: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk \(plant.name) pada \(phase.step.getText().capitalized)"),
            boldStrings: ["\(plant.name)", "\(phase.step.rawValue.capitalized)"],
            regularTextStyle: UIFont(name: "DMSans-Regular", size: 12)!,
            boldTextStyle: UIFont(name: "DMSans-Bold", size: 12)!
        )
        descLabel.adjustsFontSizeToFitWidth = true
        
        ppmLabel.attributedText = String.getStringAttributed(
            from: String(localized: "ppm-level"),
            boldStrings: [String(localized: "ppm-level")],
            regularTextStyle: UIFont(name: "DMSans-Regular", size: 15)!,
            boldTextStyle: UIFont(name: "DMSans-SemiBold", size: 15)!
        )
        ppmLabel.adjustsFontSizeToFitWidth = true
        
        ppmMin.text = String(describing: phase.min_ppm)
        ppmMax.text = String(describing: phase.max_ppm)
        phMin.text = String(describing: phase.min_ph)
        phMax.text = String(describing: phase.max_ph)
        
        saveButton.setTitle(String(localized: "save"), for: .normal)
    }
    
    @IBAction func onDismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        dismiss(animated: true)
    }
}
