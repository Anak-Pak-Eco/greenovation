//
//  DetailDeviceAlertTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class DetailDeviceAlertTableViewCell: UITableViewCell {

    @IBOutlet weak var frameView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frameView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
