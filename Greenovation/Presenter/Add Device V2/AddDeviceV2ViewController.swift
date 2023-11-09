//
//  AddDeviceV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class AddDeviceV2ViewController: UIViewController {
    
    @IBOutlet var deviceName: UITextField!
    @IBOutlet var plantName: UITextField!
    @IBOutlet var growthStepButton: UIButton!
    @IBOutlet var growthStep: LocalizableLabel!
    @IBOutlet var saveButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolbar()
        style()
    }
    
    private func setupToolbar() {
        self.title = String(localized: "pendaftaran-perangkat")
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func saveButtonTapped() {
        
    }
    
    @objc func growtStepTapped() {
        // Bottom Sheet
        let vc = DontHavePlantFormulaViewController()
        vc.modalPresentationStyle = .pageSheet
        if
            #available(iOS 15.0, *),
            let sheet = vc.sheetPresentationController
        {
            sheet.detents = [.medium()]
        }
        present(vc, animated: true, completion: nil)
    }
    
    private func style() {
        // Device Name Text Field
        deviceName.placeholder = NSLocalizedString(String(localized: "nama-perangkat"), comment: "TextField placeholder")
        deviceName.layer.borderWidth = 0.3
        deviceName.layer.borderColor = UIColor.secondaryAccent.cgColor
        deviceName.layer.cornerRadius = 10.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: deviceName.frame.size.height))
        deviceName.leftView = paddingView
        deviceName.leftViewMode = .always
        
        // Plant Name Text Field
        plantName.placeholder = NSLocalizedString(String(localized: "nama-perangkat"), comment: "TextField placeholder")
        plantName.layer.borderWidth = 0.3
        plantName.layer.borderColor = UIColor.secondaryAccent.cgColor
        plantName.layer.cornerRadius = 10.0
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: plantName.frame.size.height))
        plantName.leftView = paddingView1
        plantName.leftViewMode = .always
        
        // Growth Step Text Field
        growthStepButton.layer.borderWidth = 0.3
        growthStepButton.layer.borderColor = UIColor.secondaryAccent.cgColor
        growthStepButton.layer.cornerRadius = 10.0
        growthStepButton.clipsToBounds = true
        growthStepButton.addTarget(self, action: #selector(growtStepTapped), for: .touchUpInside)
        
        // Save Button
        saveButton.layer.borderWidth = 1.0
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
}
