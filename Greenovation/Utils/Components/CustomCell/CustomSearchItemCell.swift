//
//  CustomSearchItemCell.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

class CustomSearchItemCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet var customImageView: UIImageView!
    @IBOutlet var customLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.layer.cornerRadius = 10.0
        cellView.layer.borderWidth = 1.0
        cellView.layer.borderColor = UIColor.secondaryAccent.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with image: UIImage, and label: String) {
        customImageView.image = image
        customLabel.text = label
    }
    
    public func clearContent() {
        self.customImageView.image = nil
        self.customLabel.text = nil
    }
    
}
