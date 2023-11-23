//
//  SearchBluetoothViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import UIKit

class PairingInstructionViewController: UIViewController {

    @IBOutlet weak var pairingDescription3Label: UILabel!
    @IBOutlet weak var pairingDescription4Label: UILabel!
    @IBOutlet weak var pairingDescription1Label: UILabel!
    @IBOutlet weak var pairingDescription2Label: UILabel!
    @IBOutlet weak var pairingTitleLabel: UILabel!
    @IBOutlet weak var connectBluetoothButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
    }
    
    private func setupUI() {
        connectBluetoothButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "connect-bluetooth-title"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        pairingTitleLabel.text = String(localized: "connect-wifi-title")
        pairingDescription1Label.text = String(localized: "instruction-description-1")
        pairingDescription2Label.text = String(localized: "instruction-description-2")
        pairingDescription3Label.text = String(localized: "instruction-description-3")
        pairingDescription4Label.text = String(localized: "instruction-description-4")
    }
    
    private func setupToolbar() {
        title = String(localized: "instruction-title")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "DMSans-SemiBold", size: 17)!,
            .foregroundColor: UIColor.onPrimaryFixed
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonClicked(_:))
        )
    }
    
    @objc private func onBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onBluetoothButtonClicked(_ sender: Any) {
        let vc = BluetoothPairingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
