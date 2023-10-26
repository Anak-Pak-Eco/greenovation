//
//  AlertViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class AlertViewCell: UITableViewCell {

    @IBOutlet weak var mainFrameView: UIView!
    @IBOutlet weak var errorTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        errorTitle.text = "Test"
        mainFrameView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
