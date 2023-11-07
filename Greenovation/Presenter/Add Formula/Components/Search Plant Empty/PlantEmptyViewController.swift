//
//  PlantEmptyViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class PlantEmptyViewController: UIViewController {

    @IBOutlet var addButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ButtonStyle()
    }
    
    private func ButtonStyle() {
        addButton.layer.cornerRadius = 10.0
        if let customFont = UIFont(name: "DMSans-Bold", size: 17.0) {
            addButton.titleLabel?.font = customFont
        }
        addButton.layer.masksToBounds = true
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc func addButtonTapped() {
        print("Tapped")
    }
    
    
}
