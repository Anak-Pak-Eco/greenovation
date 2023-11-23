//
//  HavePlantFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 08/11/23.
//

import UIKit

class HavePlantFormulaViewController: UIViewController {
    
    let plantName = String(localized: "caisim")
    let growthStep = String(localized: "anakan-phase-title")
    
    @IBOutlet var ppmLabel: LocalizableLabel!
    @IBOutlet var pHLabel: LocalizableLabel!
    
    @IBOutlet var dismissButton: UIButton!
    @IBOutlet var descLabel: UILabel!
    @IBOutlet var ppmMin: UILabel!
    @IBOutlet var ppmMax: UILabel!
    @IBOutlet var phMin: UILabel!
    @IBOutlet var phMax: UILabel!
    @IBOutlet var saveButton: LocalizableButton!
    
    var delegate: AddDevicePlantFormulaDelegate?
    
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
            boldStrings: ["\(plant.name)", "\(phase.step.getText().capitalized)"],
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
        
        ppmMin.text = phase.min_ppm.clean
        ppmMax.text = phase.max_ppm.clean
        phMin.text = phase.min_ph.clean
        phMax.text = phase.max_ph.clean
        
        saveButton.setTitle(String(localized: "save"), for: .normal)
    }
    
    @IBAction func onDismissButtonClicked(_ sender: UIButton) {
        delegate?.onFormulaSelected()
        dismiss(animated: true)
    }
    
    @IBAction func onSubmitClicked(_ sender: Any) {
        delegate?.onFormulaSelected()
        dismiss(animated: true)
    }
}
