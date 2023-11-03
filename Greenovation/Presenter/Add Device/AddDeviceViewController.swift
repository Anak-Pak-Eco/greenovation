//
//  AddDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

class AddDeviceViewController: UIViewController {
    
    let sharedData = SharedData.shared
    
    @IBOutlet var myChoiceView: UIView!
    @IBOutlet var saveBtn: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        self.title = String(localized: "pendaftaran-perangkat")
        
        // Set Back Button
        let customBackButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        
        saveBtn.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        SharedData.shared.isDone.bind { [weak self] isDone in
            guard let self = self else { return }
            self.myChoiceView.isHidden = !isDone
        }
        
        // myChoiceView.isHidden = !SharedData.shared.isDone
    }
    
    func showChoicheView() {
//        if sharedData.isDone {
            // myChoiceView.isHidden = false
//        }
    }
    
    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func saveButtonTapped() {
        //
    }

}
