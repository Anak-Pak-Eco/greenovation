//
//  SignInViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var backgroundBlockingView: UIView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Button Configuration
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.primaryAccent.cgColor
        signInButton.layer.cornerRadius = 10
    }

    @IBAction func onSignUpButtonClicked(_ sender: UIButton) {
        let viewController = SignUpViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func onSignInButtonClicked(_ sender: UIButton) {
        let viewController = SignInViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
