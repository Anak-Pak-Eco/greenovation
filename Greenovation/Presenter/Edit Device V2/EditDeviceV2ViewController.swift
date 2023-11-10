//
//  EditDeviceV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 09/11/23.
//

import UIKit

class EditDeviceV2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolbar()
    }
    
    @objc func backButtonTapped() {
        
    }
    
    private func setupToolbar() {
        self.title = String(localized: "Ubah")
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
}
