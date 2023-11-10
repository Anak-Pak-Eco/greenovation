//
//  PlantSearchTableViewCell.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class PlantSearchTableViewCell: UITableViewCell {
    
    @IBOutlet var UIView: UIView!
    @IBOutlet var plantImage: UIImageView!
    @IBOutlet var plantName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    private func style() {
        UIView.layer.cornerRadius = 10.0
        UIView.layer.borderWidth = 0.3
        UIView.clipsToBounds = true
        UIView.layer.borderColor = UIColor.secondaryAccent.cgColor
    }
    
}
