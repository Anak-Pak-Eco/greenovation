//
//  SignInViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInAppleButton: UIButton!
    @IBOutlet weak var signInGoogleButton: UIButton!
    @IBOutlet weak var registerButton: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
    }
    
    private func setupUI() {
        // Mark: Input Configuration
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
    }
    
    private func setupToolbar() {
        title = "Masuk"
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setViewControllers([MainViewController()], animated: true)
    }
}
