//
//  ProfileViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 04/11/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel.text = "Sign in as: \(Auth.auth().currentUser?.displayName ?? "")"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
    }
    
    private func setupToolbar() {
        tabBarController?.title = String(localized: "profile")
        tabBarController?.navigationItem.setRightBarButton(nil, animated: true)
    }

    @IBAction func onLogoutClicked(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: "Keluar dari akun?",
            message: "Apakah anda yakin akan keluar dari akun anda?",
            preferredStyle: .alert
        )
        alertController.addAction(
            .init(
                title: "Tidak",
                style: .default,
                handler: { action in
                    alertController.dismiss(animated: true)
                }
            )
        )
        alertController.addAction(
            .init(
                title: "Ya",
                style: .destructive,
                handler: { action in
                    alertController.dismiss(animated: true)
                    do {
                        try Auth.auth().signOut()
                        self.navigationController?.setViewControllers([OnboardingViewController()], animated: true)
                    } catch {
                        let alertController = UIAlertController(
                            title: "Logout Gagal",
                            message: error.localizedDescription,
                            preferredStyle: .alert
                        )
                        alertController.addAction(
                            .init(
                                title: "OK",
                                style: .destructive,
                                handler: { action in
                                    alertController.dismiss(animated: true)
                                }
                            )
                        )
                        self.present(alertController, animated: true)
                    }
                }
            )
        )
        
        self.present(alertController, animated: true)
    }
}
