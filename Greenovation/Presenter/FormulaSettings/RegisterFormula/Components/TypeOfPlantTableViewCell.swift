//
//  TypeOfPlantTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 16/11/23.
//

import UIKit

class TypeOfPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var plantTypeLabel: UILabel!
    @IBOutlet weak var plantTypeTitleLabel: LocalizableLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        plantTypeTitleLabel.text = String(localized: "plant-type")
    }
    
    func setPlantType(_ plantType: String) {
        plantTypeLabel.text = plantType
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
