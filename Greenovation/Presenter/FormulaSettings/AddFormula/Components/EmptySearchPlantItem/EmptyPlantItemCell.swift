//
//  EmptyPlantItemCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 10/11/23.
//

import UIKit

class EmptyPlantItemCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var buttonAddPlant: UIButton!
    
    var didClickAddButton: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonAddPlant.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "add-plants"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        cardView.layer.borderColor = UIColor.secondaryAccent.cgColor
        cardView.layer.borderWidth = 0.3
        cardView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func onAddButtonClicked(_ sender: UIButton) {
        didClickAddButton?()
    }
}
