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
    @IBOutlet weak var maxPpmTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minPpmTextField.setBorder()
        maxPpmTextField.setBorder()
        minPhTextField.setBorder()
        maxPhTextField.setBorder()
    }
    
    func setRecommendation(_ text: String, isHidden: Bool) {
        recommendationLabel.text = text
        recommendationLabel.isHidden = isHidden
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
