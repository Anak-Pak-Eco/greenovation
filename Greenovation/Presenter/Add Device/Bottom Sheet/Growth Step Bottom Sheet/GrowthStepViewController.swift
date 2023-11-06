//
//  GrowthStepViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 26/10/23.
//

import UIKit

class GrowthStepViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let component = UILabel()
        component.text = String(localized: "tahap-pertumbuhan")
        component.textAlignment = .left
        component.font = UIFont.boldSystemFont(ofSize: 20)
        component.sizeToFit()
        return component
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title
        let titleButtonItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = titleButtonItem
        
        // Set Back Button
        let customBackButtonImage = UIImage(systemName: "x.circle.fill")
        let backButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.rightBarButtonItem = backButton
        
    }
    
    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
    }

}
