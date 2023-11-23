//
//  SignUpViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTitleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var signInTitleLabel: UILabel!
    @IBOutlet weak var signInButton: UILabel!
    
    private let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        observeUI()
        setupToolbar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func observeUI() {
        viewModel.isSignUpLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            signInButton.isEnabled = !isLoading
            appleSignInButton.isEnabled = !isLoading
            googleSignInButton.isEnabled = !isLoading
        }
        
        viewModel.signUpError.bind { [weak self] message in
            guard let self = self else { return }
            if !message.isEmpty {
                let alertController = UIAlertController(
                    title: "Register Gagal",
                    message: message,
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
        
        viewModel.signUpSuccess.bind { [weak self] success in
            guard let self = self else { return }
            if success {
                self.navigationController?.setViewControllers([MainViewController()], animated: true)
            }
        }
    }

    private func setupUI() {
        nameTextField.setUnderLine()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        passwordConfirmationTextField.setUnderLine()
        signInButton.isUserInteractionEnabled = true
        signInButton.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onSignInTextClicked(_:)))
        )
        
        nameTitleLabel.text = String(localized: "name")
        nameTextField.placeholder = String(localized: "name")
        emailTitleLabel.text = String(localized: "email-title")
        passwordTitleLabel.text = String(localized: "password-title")
        passwordTextField.placeholder = String(localized: "password-hint")
        passwordConfirmationTitleLabel.text = String(localized: "password-confirmation-title")
        passwordConfirmationTextField.placeholder = String(localized: "password-hint")
        registerButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-up"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        appleSignInButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in-apple"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .black
            ),
            for: .normal
        )
        googleSignInButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in-google"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .black
            ),
            for: .normal
        )
        signInTitleLabel.text = String(localized: "already-have-account")
        signInButton.text = String(localized: "sign-in")
    }
    
    @objc private func onSignInTextClicked(_ sender: Any) {
        let vc = SignInViewController()
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupToolbar() {
        title = String(localized: "sign-up")
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
    
    @IBAction func onSignUpButtonClicked(_ sender: UIButton) {
        viewModel.signUp(
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            passwordConfirmation: passwordConfirmationTextField.text ?? ""
        )
    }
    
    @IBAction func onSignInWithAppleButtonClicked(_ sender: UIButton) {
        viewModel.signInWithApple(viewController: self)
    }
    
    @IBAction func onSignInWithGoogleButtonClicked(_ sender: UIButton) {
        viewModel.signInWithGoogle(viewController: self)
    }
}
