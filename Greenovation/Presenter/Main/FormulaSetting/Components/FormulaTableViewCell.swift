//
//  FormulaTableViewCell.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 06/11/23.
//

import UIKit

class FormulaTableViewCell: UITableViewCell {
    
    @IBOutlet var formulaImage: UIImageView!
    @IBOutlet var formulaLabel: UILabel!
    @IBOutlet weak var separator: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.2)
        ])
        formulaImage.layer.cornerRadius = 10
    }
    
    func setupData(_ plant: PlantModel, isLast: Bool) {
        formulaImage.image = UIImage(named: plant.image_url) ?? UIImage(named: "image-anakan-growthstep")
        formulaLabel.text = plant.name
        separator.isHidden = isLast
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
