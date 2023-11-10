//
//  EmptyPlantItemCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 10/11/23.
//

import UIKit

class EmptyPlantItemCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.borderColor = UIColor.secondaryAccent.cgColor
        cardView.layer.borderWidth = 0.3
        cardView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
