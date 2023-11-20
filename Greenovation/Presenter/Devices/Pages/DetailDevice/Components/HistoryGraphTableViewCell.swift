//
//  HistoryGraphTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit
import SwiftUI

class HistoryGraphTableViewCell: UITableViewCell {
    
    @IBOutlet weak var frameView: UIView!
    
    override func awakeFromNib() {
        
    }
    
    func setupData(histories: [DeviceHistoryModel]) {
        print("History: \(histories)")
        let graphView = HistoryGraphView(items: histories)
        let hostingController = UIHostingController(rootView: graphView)
        frameView.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: frameView.topAnchor, constant: 0),
            hostingController.view.bottomAnchor.constraint(equalTo: frameView.bottomAnchor, constant: 0),
            hostingController.view.leadingAnchor.constraint(equalTo: frameView.leadingAnchor, constant: 0),
            hostingController.view.trailingAnchor.constraint(equalTo: frameView.trailingAnchor, constant: 0)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        // Set Selected Clicked
    }
}
