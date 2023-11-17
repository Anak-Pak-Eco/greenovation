//
//  SignUpViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
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
    }
    
    @objc private func onSignInTextClicked(_ sender: Any) {
        let vc = SignInViewController()
        navigationController?.popViewController(animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupToolbar() {
        title = "Daftar"
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
