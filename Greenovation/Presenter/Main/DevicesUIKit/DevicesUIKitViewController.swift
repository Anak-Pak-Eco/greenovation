//
//  DevicesUIKitViewController.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 23/10/23.
//

import UIKit
import SwiftUI

class DevicesUIKitViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Perangkat"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .plain,
                target: nil,
                action: nil
            ),
            animated: true
        )
        
        mainTableView.register(
            UINib(nibName: "DevicesItemTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DeviceItemCell"
        )
        mainTableView.backgroundColor = .surface
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.reloadData()
    }
}

extension DevicesUIKitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(
            withIdentifier: "DeviceItemCell",
            for: indexPath
        ) as! DevicesItemTableViewCell
        
        cell.backgroundColor = .surface
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let vc = UIHostingController(rootView: DetailDeviceView())
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        mainTableView.deselectRow(at: indexPath, animated: true)
    }
}
