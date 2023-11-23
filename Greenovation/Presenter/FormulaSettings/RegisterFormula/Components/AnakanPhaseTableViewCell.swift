//
//  AnakanPhaseTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 16/11/23.
//

import UIKit

class AnakanPhaseTableViewCell: UITableViewCell {
    
    @IBOutlet weak var maxPhTextField: UITextField!
    @IBOutlet weak var minPhTextField: UITextField!
    @IBOutlet weak var maxPpmTextField: UITextField!
    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var titleLabel: LocalizableLabel!
    @IBOutlet weak var minPpmTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = String(localized: "anakan")
        minPpmTextField.setBorder()
        maxPpmTextField.setBorder()
        minPhTextField.setBorder()
        maxPhTextField.setBorder()
        recommendationLabel.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setRecommendation(_ text: String, isHidden: Bool) {
        recommendationLabel.text = text
        recommendationLabel.isHidden = isHidden
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

extension UITextField {
    func setBorder() {
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryAccent.cgColor
        self.clipsToBounds = true
    }
    
    func removeBorder() {
        self.borderStyle = .none
        self.layer.cornerRadius = 0
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = .clear
        self.clipsToBounds = true
    }
}
