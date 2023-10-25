//
//  DevicesItemTableViewCell.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 23/10/23.
//

import UIKit

class DevicesItemTableViewCell: UITableViewCell {

    @IBOutlet weak var frameView: UIView!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceStatusLabel: UILabel!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var ppmLabel: UILabel!
    @IBOutlet weak var phLabel: UILabel!
    @IBOutlet weak var phaseImage: UIImageView!
    @IBOutlet weak var phaseLabel: UILabel!
    
    private var device: DeviceModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frameView.layer.cornerRadius = 10
        frameView.dropShadow()
    }
    
    func setup(device: DeviceModel) {
        self.device = device
        deviceNameLabel.text = device.name
        ppmLabel.text = String.format(device.currentPpm, format: "%.2f")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
