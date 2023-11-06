//
//  EditDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit

class EditDeviceViewController: UIViewController {
    
    @IBOutlet var BackgroundView: UIView!
    @IBOutlet var SensorView: UIView!
    @IBOutlet var MyChoiceView: CustomMyChoiceView!
    @IBOutlet weak var saveButton: LocalizableButton!
    @IBOutlet weak var deleteButton: LocalizableButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Title
        self.title = String(localized: "pengaturan-perangkat")
        
        // Set Back Button
        let customBackButtonImage = UIImage(systemName: "chevron.left")
        let backButton = UIBarButtonItem(image: customBackButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = backButton
        
        saveButtonStyle()
        deleteButtonStyle()
        
        view.backgroundColor = .surface

        BGConstraint()
    }
    
    func BGConstraint() {
        NSLayoutConstraint.activate([
            BackgroundView.topAnchor.constraint(equalTo: SensorView.bottomAnchor, constant: 15),
            BackgroundView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            BackgroundView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func saveButtonStyle() {
        saveButton.backgroundColor = UIColor.primaryAccent
        saveButton.layer.cornerRadius = 10.0
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: BackgroundView.bottomAnchor, constant: 15),
            saveButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            saveButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }

    func deleteButtonStyle() {
        deleteButton.layer.borderColor = UIColor.primaryAccent.cgColor
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.cornerRadius = 10.0
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
    }
    
    @objc func backButtonTapped() {
//        self.navigationController?.popViewController(animated: true)
        
    }
    
    @objc func deleteButtonTapped() {
        // POP UP SHOW
        DeleteDeviceViewController.showPopup(parentVC: self)
    }
    
    @objc func saveButtonTapped() {
        SaveSuccessViewController.showPopup(parentVC: self)
    }

}
