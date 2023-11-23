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
        plantNameLabel.text = device.plant.name
        ppmLabel.text = device.currentPpm.clean
        phLabel.text = device.currentPh.clean
        let phase = PlantModel.PlantPhaseModel.Step(rawValue: device.currentSteps)
        phaseLabel.text = phase?.getText() ?? ""
        deviceStatusLabel.text = device.status.capitalized
        phaseImage.image = UIImage(named: getPlantImage(phaseName: device.currentSteps))
        
        errorStackView.subviews.forEach { view in
            errorStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        if device.currentPpm < device.plant.min_ppm {
            let alertView = AlertView()
            alertView.setLabel(
                String.getStringAttributed(
                    from: String(localized: "low-ppm-alert"),
                    boldStrings: [String(localized: "low")]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        } else if device.currentPpm > device.plant.max_ppm {
            let alertView = AlertView()
            alertView.setLabel(
                String.getStringAttributed(
                    from: String(localized: "high-ppm-alert"),
                    boldStrings: [String(localized: "high")]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        }
        
        if device.currentPh < device.plant.min_ph {
            let alertView = AlertView()
            alertView.setLabel(
                String.getStringAttributed(
                    from: String(localized: "low-ph-alert"),
                    boldStrings: [String(localized: "low")]
                )
            )
            errorStackView.addArrangedSubview(alertView)
        } else if device.currentPh > device.plant.max_ph {
            let alertView = AlertView()
            alertView.setLabel(
                String.getStringAttributed(
                    from: String(localized: "high-ph-alert"),
                    boldStrings: [String(localized: "high")]
                )
            )
            
            errorStackView.addArrangedSubview(alertView)
        }
    }
    
    private func getPlantImage(phaseName: String) -> String {
        if phaseName == PlantModel.PlantPhaseModel.Step.anakan.rawValue {
            return "image-anakan"
        } else if phaseName == PlantModel.PlantPhaseModel.Step.vegetatif_awal.rawValue {
            return "image-awal"
        } else {
            return "image-menengah"
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
