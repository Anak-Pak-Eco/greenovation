//
//  SignInViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 26/10/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var onboardingTitleLabel: UILabel!
    @IBOutlet weak var onboardingDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Button Configuration
        signUpButton.layer.cornerRadius = 10
        signUpButton.layer.borderWidth = 1
        signUpButton.layer.borderColor = UIColor.primaryAccent.cgColor
        signInButton.layer.cornerRadius = 10
        
        // Set Text
        onboardingTitleLabel.text = String(localized: "onboarding-title")
        onboardingDescriptionLabel.text = String(localized: "onboarding-description")
        signInButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-in"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        signUpButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "sign-up"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!
            ),
            for: .normal
        )
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
