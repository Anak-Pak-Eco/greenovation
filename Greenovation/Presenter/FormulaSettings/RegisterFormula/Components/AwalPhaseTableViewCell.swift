//
//  AwalPhaseTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 16/11/23.
//

import UIKit

class AwalPhaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var maxPhTextField: UITextField!
    @IBOutlet weak var minPhTextField: UITextField!
    @IBOutlet weak var minPpmTextField: UITextField!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maxPpmTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = String(localized: "awal")
        minPpmTextField.setBorder()
        maxPpmTextField.setBorder()
        minPhTextField.setBorder()
        maxPhTextField.setBorder()
        recommendationLabel.isHidden = true
    }
    
    func setRecommendation(_ text: String, isHidden: Bool) {
        recommendationLabel.text = text
        recommendationLabel.isHidden = isHidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(isEditingMode: Bool, phase: PlantModel.PlantPhaseModel) {
        minPpmTextField.isEnabled = isEditingMode
        maxPpmTextField.isEnabled = isEditingMode
        minPhTextField.isEnabled = isEditingMode
        maxPhTextField.isEnabled = isEditingMode
        
        if isEditingMode {
            minPpmTextField.setBorder()
            maxPpmTextField.setBorder()
            minPhTextField.setBorder()
            maxPhTextField.setBorder()
        } else {
            minPpmTextField.removeBorder()
            maxPpmTextField.removeBorder()
            minPhTextField.removeBorder()
            maxPhTextField.removeBorder()
        }
        
        minPpmTextField.text = phase.min_ppm.clean
        maxPpmTextField.text = phase.max_ppm.clean
        minPhTextField.text = phase.min_ph.clean
        maxPhTextField.text = phase.max_ph.clean
    }
}
