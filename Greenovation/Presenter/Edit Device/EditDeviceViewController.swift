//
//  EditDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit

class EditDeviceViewController: UIViewController {
    
    @IBOutlet weak var saveButton: LocalizableButton!
    @IBOutlet weak var deleteButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(localized: "pengaturan-perangkat")
        
        saveButtonStyle()
        deleteButtonStyle()
        
        view.backgroundColor = .surface

        // Do any additional setup after loading the view.
    }
    
    func saveButtonStyle() {
        saveButton.backgroundColor = UIColor.primaryAccent
        saveButton.layer.cornerRadius = 10.0
    }

    func deleteButtonStyle() {
        deleteButton.layer.borderColor = UIColor.primaryAccent.cgColor
        deleteButton.layer.borderWidth = 1.0
        deleteButton.layer.cornerRadius = 10.0
    }

}
