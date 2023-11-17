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
    @IBOutlet weak var minPpmTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        minPpmTextField.setBorder()
        maxPpmTextField.setBorder()
        minPhTextField.setBorder()
        maxPhTextField.setBorder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setRecommendation(_ text: String, isHidden: Bool) {
        recommendationLabel.text = text
        recommendationLabel.isHidden = isHidden
    }
}

extension UITextField {
    func setBorder() {
        self.layer.cornerRadius = 6
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.primaryAccent.cgColor
        self.clipsToBounds = true
    }
}
