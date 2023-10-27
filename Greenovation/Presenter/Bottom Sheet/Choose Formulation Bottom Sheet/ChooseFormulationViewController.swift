//
//  ChooseFormulationViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

class ChooseFormulationViewController: UIViewController {

    @IBOutlet weak var saveButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButtonStyle()
        
    }
    
    func saveButtonStyle() {
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.backgroundColor = UIColor.primaryAccent
        saveButton.layer.borderWidth = 1.0
        saveButton.layer.cornerRadius = 10.0
    }

}
