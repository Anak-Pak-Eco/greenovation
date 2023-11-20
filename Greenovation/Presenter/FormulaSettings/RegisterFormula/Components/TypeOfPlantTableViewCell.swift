//
//  TypeOfPlantTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 16/11/23.
//

import UIKit

class TypeOfPlantTableViewCell: UITableViewCell {

    @IBOutlet weak var plantTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setPlantType(_ plantType: String) {
        plantTypeLabel.text = plantType
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
