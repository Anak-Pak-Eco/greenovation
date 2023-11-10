//
//  DetailFormulaV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 10/11/23.
//

import UIKit

class DetailFormulaViewController: UIViewController {
    @IBOutlet var plantName: UILabel!
    @IBOutlet var ppmMinFaseAnakan: UILabel!
    @IBOutlet var ppmMaxFaseAnakan: UILabel!
    @IBOutlet var phMinFaseAnakan: UILabel!
    @IBOutlet var phMaxFaseAnakan: UILabel!
    @IBOutlet var ppmMinFaseAwal: UILabel!
    @IBOutlet var ppmMaxFaseAwal: UILabel!
    @IBOutlet var phMinFaseAwal: UILabel!
    @IBOutlet var phMaxFaseAwal: UILabel!
    @IBOutlet var ppmMinFaseMenengah: UILabel!
    @IBOutlet var ppmMaxFaseMenengah: UILabel!
    @IBOutlet var phMinFaseMenengah: UILabel!
    @IBOutlet var phMaxFaseMenengah: UILabel!
    @IBOutlet var deleteButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        setupToolbar()
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func editButtonTapped() {
        
    }
    
    @objc func deleteButtonTapped() {
        
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
        
        let editButton = UIBarButtonItem(
            title: String(localized: "edit"),
            style: .plain,
            target: self,
            action: #selector(editButtonTapped)
        )
        navigationItem.setRightBarButton(editButton, animated: true)
    }
}
