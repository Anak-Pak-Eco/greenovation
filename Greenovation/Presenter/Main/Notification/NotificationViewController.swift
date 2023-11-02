//
//  NotificationViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private let viewModel = NotificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        viewModel.getNotifications()
    }
    
    private func setupToolbar() {
        tabBarController?.title = "Notifikasi"
    }
}
