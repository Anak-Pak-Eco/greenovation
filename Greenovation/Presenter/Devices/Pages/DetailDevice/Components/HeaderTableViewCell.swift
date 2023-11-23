//
//  HeaderTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var plantImageView: UIImageView!
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var phLabel: UILabel!
    @IBOutlet weak var ppmLabel: UILabel!
    @IBOutlet weak var phaseLabel: UILabel!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var labelUIView: UIView!
    
    var didSelectEditButton: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupData(device: DeviceModel) {
        plantNameLabel.text = device.plant.name
        ppmLabel.text = device.currentPpm.clean
        phLabel.text = device.currentPh.clean
        let phase = PlantModel.PlantPhaseModel.Step(rawValue: device.currentSteps)
        phaseLabel.text = phase?.getText()
        editButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "update"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 12)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        
        if device.currentSteps == PlantModel.PlantPhaseModel.Step.anakan.rawValue {
            plantImageView.image = UIImage(named: "image-anakan")
        } else if device.currentSteps == PlantModel.PlantPhaseModel.Step.vegetatif_awal.rawValue {
            plantImageView.image = UIImage(named: "image-awal")
        } else if device.currentSteps == PlantModel.PlantPhaseModel.Step.vegetatif_menengah.rawValue {
            plantImageView.image = UIImage(named: "image-menengah")
        } else {
            plantImageView.image = UIImage(named: "image-anakan")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func editButtonTapped(_ sender: Any) {
        didSelectEditButton?()
    }
    
    private func setupUI() {
        // Edit Button
        editButton.titleLabel?.font = UIFont(name: "DMSans-SemiBold", size: 12)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        // Label UI View
        labelUIView.layer.borderWidth = 1
        labelUIView.layer.borderColor = UIColor.surfaceDim.cgColor
        labelUIView.layer.cornerRadius = 10
    }
}
