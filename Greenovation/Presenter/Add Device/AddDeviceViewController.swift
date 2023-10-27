//
//  AddDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

class AddDeviceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        self.title = String(localized: "pendaftaran-perangkat")
        
        // Set Back Button
        let customBackButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
    }

}
