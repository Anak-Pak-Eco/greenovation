//
//  SearchBluetoothViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import UIKit

class PairingInstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
    }
    
    private func setupToolbar() {
        title = "Instruksi"
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
