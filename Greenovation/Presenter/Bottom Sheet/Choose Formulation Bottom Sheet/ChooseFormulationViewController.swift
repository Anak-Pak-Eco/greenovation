//
//  ChooseFormulationViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

class ChooseFormulationViewController: UIViewController {

    @IBOutlet weak var saveButton: LocalizableButton!
    
    let titleLabel: UILabel = {
        let component = UILabel()
        component.text = String(localized: "pilih-satu-formula")
        component.textAlignment = .left
        component.font = UIFont.boldSystemFont(ofSize: 20)
        return component
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonStyle()
        
        // Set Title
        let titleButtonItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = titleButtonItem
        
        // Set Back Button
        let customBackButtonImage = UIImage(systemName: "x.circle.fill")
        let backButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.rightBarButtonItem = backButton
        
    }
    
    func saveButtonStyle() {
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.backgroundColor = UIColor.primaryAccent
        saveButton.layer.borderWidth = 1.0
        saveButton.layer.cornerRadius = 10.0
    }
    
    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
    }

}
