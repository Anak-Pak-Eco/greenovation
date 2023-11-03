//
//  DetailDeviceAlertTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class DetailDeviceAlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alertStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(phLevel: Double, ppmLevel: Double) {
        alertStackView.subviews.forEach { view in
            alertStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        if ppmLevel < 200 {
            let alertView = AlertLargeView()
            let valueToAdd = (5 * (200 - ppmLevel)) / 1000
            alertView.setText(
                title: String.getStringAttributed(
                    from: "Nilai PPM rendah",
                    boldStrings: ["Nilai PPM rendah"]
                ),
                description: String.getStringAttributed(
                    from: "Tambahkan larutan nutrisi A dan B sebanyak \(valueToAdd)ml untuk menjaga keseimbangan nutrisi",
                    boldStrings: ["\(valueToAdd)ml"]
                )
            )
            alertStackView.addArrangedSubview(alertView)
        } else if ppmLevel > 400 {
            let alertView = AlertLargeView()
            alertView.setText(
                title: String.getStringAttributed(
                    from: "Nilai PPM tinggi",
                    boldStrings: ["Nilai PPM tinggi"]
                ),
                description: String.getStringAttributed(
                    from: "Tambahkan air bersih sampai keseimbangan nutrisi tercapai kembali."
                )
            )
            alertStackView.addArrangedSubview(alertView)
        }
        
        if phLevel < 200 {
            let alertView = AlertLargeView()
            let valueToAdd = (0.7692 * 1) - (0.6 * phLevel) + (0.3 * 400)
            alertView.setText(
                title: String.getStringAttributed(
                    from: "Nilai pH rendah",
                    boldStrings: ["Nilai pH rendah"]
                ),
                description: String.getStringAttributed(
                    from: "Tambahkan larutan ph UP sebanyak \(String.format(valueToAdd, format: "%.2f")) ml untuk menjaga keseimbangan pH larutan hidroponik.",
                    boldStrings: ["rendah"]
                )
            )
            alertStackView.addArrangedSubview(alertView)
        } else if ppmLevel > 400 {
            let alertView = AlertLargeView()
            let valueToAdd = (0.0925 * 1) - (0.02 * phLevel) + (0.25 * 200)
            alertView.setText(
                title: String.getStringAttributed(from: "Nilai pH tinggi", boldStrings: ["Nilai pH tinggi"]),
                description: String.getStringAttributed(
                    from: "Tambahkan larutan ph DOWN sebanyak \(valueToAdd) ml untuk menjaga keseimbangan pH larutan hidroponik",
                    boldStrings: ["tinggi"]
                )
            )
            alertStackView.addArrangedSubview(alertView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
