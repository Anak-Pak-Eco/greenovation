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
    @IBOutlet weak var errorStackView: UIStackView!
    
    private var device: DeviceModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        frameView.layer.cornerRadius = 10
        frameView.dropShadow()
    }
    
    func setup(device: DeviceModel) {
        self.device = device
        deviceNameLabel.text = device.name
        plantNameLabel.text = device.plantId
        ppmLabel.text = String.format(device.currentPpm, format: "%.2f")
        phLabel.text = String.format(device.currentPh, format: "%.2f")
        phaseLabel.text = device.currentSteps.capitalized
        deviceStatusLabel.text = device.deviceStatus
        
        errorStackView.subviews.forEach { view in
            errorStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        if device.currentPpm < 200 {
            let alertView = AlertView()
            let valueToAdd = (5 * (200 - device.currentPpm)) / 1000
            alertView.setLabel(
                String.getStringAttributed(
                    from: "Nilai PPM rendah. Tambahkan larutan nutrisi A dan B sebanyak \(valueToAdd) ml untuk menjaga keseimbangan nutrisi",
                    boldStrings: ["rendah"]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        } else if device.currentPpm > 400 {
            let alertView = AlertView()
            alertView.setLabel(
                String.getStringAttributed(from: "Nilai PPM tinggi. Tambahkan air bersih sampai keseimbangan nutrisi tercapai kembali.", boldStrings: ["tinggi"])
            )
            errorStackView.addArrangedSubview(alertView)
        }
        
        if device.currentPh < 200 {
            let alertView = AlertView()
            let valueToAdd = (0.7692 * 1) - (0.6 * device.currentPpm) + (0.3 * 400)
            alertView.setLabel(
                String.getStringAttributed(
                    from: "Nilai pH rendah. Tambahkan larutan ph UP sebanyak \(String.format(valueToAdd, format: "%.2f")) ml untuk menjaga keseimbangan pH larutan hidroponik.",
                    boldStrings: ["rendah"]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        } else if device.currentPpm > 400 {
            let alertView = AlertView()
            let valueToAdd = (0.0925 * 1) - (0.02 * device.currentPh) + (0.25 * 200)
            alertView.setLabel(
                String.getStringAttributed(
                    from: "Nilai pH tinggi. Tambahkan larutan ph DOWN sebanyak \(valueToAdd) ml untuk menjaga keseimbangan pH larutan hidroponik",
                    boldStrings: ["tinggi"]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
