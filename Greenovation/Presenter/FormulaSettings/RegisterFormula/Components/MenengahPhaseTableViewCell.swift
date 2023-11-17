//
//  MenengahPhaseTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 17/11/23.
//

import UIKit

class MenengahPhaseTableViewCell: UITableViewCell {

    @IBOutlet weak var recommendationLabel: UILabel!
    @IBOutlet weak var maxPhTextField: UITextField!
    @IBOutlet weak var minPhTextField: UITextField!
    @IBOutlet weak var maxPpmTextField: UITextField!
    @IBOutlet weak var minPpmTextField: UITextField!
    
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
