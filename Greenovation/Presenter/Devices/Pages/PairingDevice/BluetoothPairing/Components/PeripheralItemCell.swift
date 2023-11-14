//
//  PeripheralItemCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import UIKit

class PeripheralItemCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var bluetoothNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
    }
    
    func setup(name: String, isLast: Bool, isFirst: Bool) {
        if isLast {
            let path = UIBezierPath(
                roundedRect: mainView.bounds,
                byRoundingCorners:[.bottomLeft, .bottomRight],
                cornerRadii: CGSize(width: 10, height:  10)
            )
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            mainView.layer.mask = maskLayer
        }
        
        if isFirst {
            let path = UIBezierPath(
                roundedRect: mainView.bounds,
                byRoundingCorners:[.topRight, .topLeft],
                cornerRadii: CGSize(width: 10, height:  10)
            )
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            mainView.layer.mask = maskLayer
        }
        
        bluetoothNameLabel.text = name
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
