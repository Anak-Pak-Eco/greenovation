//
//  SignInViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInAppleButton: UIButton!
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var registerButton: UILabel!
    @IBOutlet weak var registerTitleLabel: UILabel!
    
    private let viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.signInSuccess.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                self.navigationController?.setViewControllers([MainViewController()], animated: true)
            }
        }
        
        viewModel.signInError.bind { [weak self] message in
            guard let self = self else { return }
            if !message.isEmpty {
                let alertController = UIAlertController(
                    title: "Login Gagal",
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
        
        viewModel.isSignInLoading.bind { [weak self] isLoading in
            guard let self = self else { return }
            signInButton.isEnabled = !isLoading
            signInAppleButton.isEnabled = !isLoading
            signInGoogleButton.isEnabled = !isLoading
        }
        
        setupToolbar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupUI() {
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        registerButton.isUserInteractionEnabled = true
        registerButton.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(onRegisterClicked(_:)))
        )
        
        emailTitleLabel.text = String(localized: "email-title")
        passwordTitleLabel.text = String(localized: "password-title")
        passwordTextField.placeholder = String(localized: "password-hint")
        signInButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        orLabel.text = String(localized: "or")
        signInAppleButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in-apple"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .black
            ),
            for: .normal
        )
        signInGoogleButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in-google"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .black
            ),
            for: .normal
        )
        registerTitleLabel.text = String(localized: "do-not-have-account")
        registerButton.text = String(localized: "sign-up")
    }
    
    @objc private func onRegisterClicked(_ sender: UILabel) {
        let vc = SignUpViewController()
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupToolbar() {
        title = String(localized: "sign-in")
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
    
    @IBAction func onSignInButtonClicked(_ sender: UIButton) {
        viewModel.signIn(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func onSignInGoogleClicked(_ sender: UIButton) {
        viewModel.signInWithGoogle(viewController: self)
    }
    
    
    @IBAction func onSignInWithAppleButtonClicked(_ sender: UIButton) {
        viewModel.signInWithApple(viewController: self)
    }
}
