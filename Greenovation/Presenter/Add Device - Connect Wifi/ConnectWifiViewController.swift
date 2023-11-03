//
//  ConnectWifiViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit
import NetworkExtension

class ConnectWifiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        getWifiList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupToolbar() {
        title = "Wifi"
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
    
    @objc func onBackButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension ConnectWifiViewController {
    private func getWifiList() {
        NEHotspotHelper.register(queue: DispatchQueue.main) { command in
            if command.commandType == .filterScanList {
                command.networkList?.forEach { network in
                    print("Network: \(network.ssid)")
                }
            }
        }
    }
}
