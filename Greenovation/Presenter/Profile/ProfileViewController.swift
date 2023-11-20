//
//  ProfileViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 04/11/23.
//

import UIKit
import FirebaseAuth

final class ProfileViewController: UIViewController {

    @IBOutlet weak var deleteAccountButton: UIStackView!
    @IBOutlet weak var privacyPolicyButton: UIStackView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactUsButton: UIStackView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    private var editButton: UIBarButtonItem?
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUser()
        setupObserver()
        setupUI()
    }
    
    private func setupObserver() {
        viewModel.errorUpdateProfile.bind { [unowned self] error in
            if !error.isEmpty {
                editButton?.title = "Edit"
                nameTextField.textColor = UIColor.onPrimaryContainer
                nameTextField.isEnabled = false
                
                let alertController = UIAlertController(
                    title: "Login Gagal",
                    message: error,
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
        
        viewModel.successUpdateProfile.bind { [unowned self] success in
            if success {
                let alertController = UIAlertController(
                    title: "Ubah Profil",
                    message: "Berhasil mengubah profile",
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
                
                editButton?.title = "Edit"
                nameTextField.textColor = UIColor.onPrimaryContainer
                nameTextField.isEnabled = false
            }
        }
        
        viewModel.loadingProfile.bind { [unowned self] isLoading in
            editButton?.isEnabled = !isLoading
            signOutButton.isEnabled = !isLoading
        }
    }
    
    private func setupUI() {
        nameTextField.isEnabled = false
        emailLabel.text = viewModel.user?.email ?? "-"
        nameTextField.text = viewModel.user?.displayName ?? ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
    }
    
    private func setupToolbar() {
        title = String(localized: "profile")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar .titleTextAttributes = [
            .font: UIFont(name: "DMSans-SemiBold", size: 17)!,
            .foregroundColor: UIColor.onPrimaryFixed
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonClicked(_:))
        )
        
        editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(onEditButtonClicked(_:))
        )
        navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    @objc private func onBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onEditButtonClicked(_ sender: Any) {
        if (viewModel.editMode) {
            editButton?.isEnabled = false
            nameTextField.isEnabled = false
            viewModel.updateUser(name: nameTextField.text ?? "")
        } else {
            editButton?.title = "Simpan"
            nameTextField.isEnabled = true
            nameTextField.textColor = UIColor.primaryAccent
        }
        
        viewModel.editMode.toggle()
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
