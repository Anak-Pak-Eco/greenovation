//
//  DevicesUIKitViewController.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 23/10/23.
//

import UIKit
import SwiftUI

class DevicesViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    private let viewModel = DevicesViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        setupToolbar()
        navigationController?.forceUpdateNavbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.successGetDevices.bind { [weak self] _ in
            guard let self = self else { return }
            mainTableView.reloadData()
        }
        viewModel.getDevices()
    }
    
    private func setupToolbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.title = "Perangkat"
        tabBarController?.navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .plain,
                target: self,
                action: #selector(onAddDeviceClicked(_:))
            ),
            animated: true
        )
    }
    
    @objc private func onAddDeviceClicked(_ sender: UIBarButtonItem) {
//        let viewController = ScanQRViewController()
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupUI() {
        mainTableView.register(
            UINib(nibName: "DevicesItemTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DeviceItemCell"
        )
        mainTableView.backgroundColor = .surface
        mainTableView.dataSource = self
        mainTableView.delegate = self
    }
}

extension DevicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(
            withIdentifier: "DeviceItemCell",
            for: indexPath
        ) as! DevicesItemTableViewCell
        
        let device = viewModel.devices[indexPath.row]
        cell.setup(device: device)
        cell.selectionStyle = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailDeviceViewController(deviceId: viewModel.devices[indexPath.row].id)
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension UINavigationController {
    func forceUpdateNavbar() {
        DispatchQueue.main.async {
            self.navigationBar.sizeToFit()
        }
    }
}
