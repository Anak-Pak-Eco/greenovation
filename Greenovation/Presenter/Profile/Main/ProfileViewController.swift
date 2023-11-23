//
//  ProfileViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 04/11/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var deleteAccountLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var contactUsLabel: UILabel!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var personalInfoLabel: UILabel!
    @IBOutlet weak var deleteAccountButton: UIStackView!
    @IBOutlet weak var privacyPolicyButton: UIStackView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactUsButton: UIStackView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var nameTitleLabel: UILabel!
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
                editButton?.title = String(localized: "edit")
                nameTextField.textColor = UIColor.onPrimaryContainer
                nameTextField.isEnabled = false
                
                let alertController = UIAlertController(
                    title: "Failed to update profile",
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
                    title: String(localized: "update-profile-title"),
                    message: String(localized: "update-profile-description"),
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
                
                editButton?.title = String(localized: "edit")
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
        nameTitleLabel.text = String(localized: "name")
        nameTextField.isEnabled = false
        emailLabel.text = viewModel.user?.email ?? "-"
        nameTextField.text = viewModel.user?.displayName ?? ""
        
        personalInfoLabel.text = String(localized: "personal-info")
        helpLabel.text = String(localized: "help")
        contactUsLabel.text = String(localized: "contact-us")
        privacyPolicyLabel.text = String(localized: "privacy-policy")
        deleteAccountLabel.text = String(localized: "delete-account")
        signOutButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-out"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .errorAccent
            ),
            for: .normal
        )
        
        let tapGestureDetector = UITapGestureRecognizer(target: self, action: #selector(onSelectedPrivacyPolicyButton(_:)))
        privacyPolicyButton.addGestureRecognizer(tapGestureDetector)
        
        let contactUsTapGestureDetector = UITapGestureRecognizer(
            target: self,
            action: #selector(onContactUsClicked(_:))
        )
        contactUsButton.addGestureRecognizer(contactUsTapGestureDetector)
        
        let deleteAccountTapGestureDetector = UITapGestureRecognizer(
            target: self,
            action: #selector(onContactUsClicked(_:))
        )
        deleteAccountButton.addGestureRecognizer(deleteAccountTapGestureDetector)
    }
    
    @objc private func onSelectedPrivacyPolicyButton(_ sender: UIStackView) {
        let vc = WebPageViewController(url: "https://greenovation-landing-page.vercel.app/privacy-policy")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func onContactUsClicked(_ sender: UIStackView) {
        let vc = WebPageViewController(url: "https://greenovation-landing-page.vercel.app/contact")
        navigationController?.pushViewController(vc, animated: true)
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
            title: String(localized: "edit"),
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
            editButton?.title = String(localized: "save")
            nameTextField.isEnabled = true
            nameTextField.textColor = UIColor.primaryAccent
        }
        
        viewModel.editMode.toggle()
    }

    @IBAction func onLogoutClicked(_ sender: UIButton) {
        
        let alertController = UIAlertController(
            title: String(localized: "sign-out-title"),
            message: String(localized: "sign-out-description"),
            preferredStyle: .alert
        )
        alertController.addAction(
            .init(
                title: String(localized: "no"),
                style: .default,
                handler: { action in
                    alertController.dismiss(animated: true)
                }
            )
        )
        alertController.addAction(
            .init(
                title: String(localized: "yes"),
                style: .destructive,
                handler: { action in
                    alertController.dismiss(animated: true)
                    do {
                        try Auth.auth().signOut()
                        self.navigationController?.setViewControllers([OnboardingViewController()], animated: true)
                    } catch {
                        let alertController = UIAlertController(
                            title: "Failed to Sign Out",
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
