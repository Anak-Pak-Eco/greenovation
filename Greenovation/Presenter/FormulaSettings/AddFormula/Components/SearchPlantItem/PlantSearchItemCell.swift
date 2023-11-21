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
    
    var didSelectPlant: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
        cardView.layer.borderWidth = 0.3
        cardView.layer.borderColor = UIColor.secondaryAccent.cgColor
        cardView.layer.backgroundColor = UIColor.white.cgColor
        cardView.clipsToBounds = true
        cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectedPlant(_:))))
        
        plantImage.layer.cornerRadius = 10
    }
    
    @objc private func onSelectedPlant(_ sender: Any) {
        didSelectPlant?()
    }
    
    func setup(plant: PlantModel) {
        plantLabel.text = plant.name
        plantImage.image = UIImage(named: plant.image_url.isEmpty ? "image-plant-default" : plant.image_url)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
