//
//  PlantSearchTableViewCell.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class PlantSearchItemCell: UITableViewCell {
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var plantLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 0.3
        cardView.layer.borderColor = UIColor.secondaryAccent.cgColor
        cardView.clipsToBounds = true
        
        plantImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
