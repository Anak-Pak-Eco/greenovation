//
//  DetailDeviceAlertTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class DetailDeviceAlertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alertStackView: UIStackView!
    var didSelectDoneButton: ((AlertType) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupData(alerts: [Alert]) {
        alertStackView.subviews.forEach { view in
            alertStackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        alerts.forEach { alert in
            let alertView = AlertLargeView()
            alertView.didClickOnDeleteButton = { [unowned self] in
                didSelectDoneButton?(alert.type)
            }
            alertView.setText(
                title: alert.title,
                description: alert.message
            )
            alertStackView.addArrangedSubview(alertView)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
