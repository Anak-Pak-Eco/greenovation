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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
    }

    private func setupUI() {
        // Mark: Input Configuration
        nameTextField.setUnderLine()
        emailTextField.setUnderLine()
        passwordTextField.setUnderLine()
        passwordConfirmationTextField.setUnderLine()
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
}
