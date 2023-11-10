//
//  EditFormulaV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 10/11/23.
//

import UIKit

class EditFormulaViewController: UIViewController {
    
    @IBOutlet var plantName: UILabel!
    @IBOutlet var ppmMinFaseAnakan: UITextField!
    @IBOutlet var ppmMaxFaseAnakan: UITextField!
    @IBOutlet var phMinFaseAnakan: UITextField!
    @IBOutlet var phMaxFaseAnakan: UITextField!
    @IBOutlet var ppmMinFaseAwal: UITextField!
    @IBOutlet var ppmMaxFaseAwal: UITextField!
    @IBOutlet var phMinFaseAwal: UITextField!
    @IBOutlet var phMaxFaseAwal: UITextField!
    @IBOutlet var ppmMinFaseMenengah: UITextField!
    @IBOutlet var ppmMaxFaseMenengah: UITextField!
    @IBOutlet var phMinFaseMenengah: UITextField!
    @IBOutlet var phMaxFaseMenengah: UITextField!
    @IBOutlet var deleteButton: LocalizableButton!
    @IBOutlet var ppmLabelFaseAnakan: LocalizableLabel!
    @IBOutlet var ppmLabelFaseAwal: LocalizableLabel!
    @IBOutlet var ppmLabelFaseMenengah: LocalizableLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        setupToolbar()
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func saveButtonTapped() {
        
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
            title: String(localized: "simpan"),
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    private func style() {
        // ppm Label
        ppmLabelFaseAnakan.adjustsFontSizeToFitWidth = true
        ppmLabelFaseAwal.adjustsFontSizeToFitWidth = true
        ppmLabelFaseMenengah.adjustsFontSizeToFitWidth = true
        
        // Fase Anakan ppm Min
        ppmMinFaseAnakan.layer.cornerRadius = 6
        ppmMinFaseAnakan.layer.borderWidth = 1.0
        ppmMinFaseAnakan.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMinFaseAnakan.clipsToBounds = true
        
        // Fase Anakan ppm Max
        ppmMaxFaseAnakan.layer.cornerRadius = 6
        ppmMaxFaseAnakan.layer.borderWidth = 1.0
        ppmMaxFaseAnakan.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMaxFaseAnakan.clipsToBounds = true
        
        // Fase Anakan ph Min
        phMinFaseAnakan.layer.cornerRadius = 6
        phMinFaseAnakan.layer.borderWidth = 1.0
        phMinFaseAnakan.layer.borderColor = UIColor.primaryAccent.cgColor
        phMinFaseAnakan.clipsToBounds = true
        
        // Fase Anakan ph Max
        phMaxFaseAnakan.layer.cornerRadius = 6
        phMaxFaseAnakan.layer.borderWidth = 1.0
        phMaxFaseAnakan.layer.borderColor = UIColor.primaryAccent.cgColor
        phMaxFaseAnakan.clipsToBounds = true
        
        // Fase Vegetatif Awal ppm Min
        ppmMinFaseAwal.layer.cornerRadius = 6
        ppmMinFaseAwal.layer.borderWidth = 1.0
        ppmMinFaseAwal.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMinFaseAwal.clipsToBounds = true
        
        // Fase Vegetatif Awal ppm Max
        ppmMaxFaseAwal.layer.cornerRadius = 6
        ppmMaxFaseAwal.layer.borderWidth = 1.0
        ppmMaxFaseAwal.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMaxFaseAwal.clipsToBounds = true
        
        // Fase Vegetatif Awal ph Min
        phMinFaseAwal.layer.cornerRadius = 6
        phMinFaseAwal.layer.borderWidth = 1.0
        phMinFaseAwal.layer.borderColor = UIColor.primaryAccent.cgColor
        phMinFaseAwal.clipsToBounds = true
        
        // Fase Vegetatif Awal ph Max
        phMaxFaseAwal.layer.cornerRadius = 6
        phMaxFaseAwal.layer.borderWidth = 1.0
        phMaxFaseAwal.layer.borderColor = UIColor.primaryAccent.cgColor
        phMaxFaseAwal.clipsToBounds = true
        
        // Fase Vegetatif Menengah ppm Min
        ppmMinFaseMenengah.layer.cornerRadius = 6
        ppmMinFaseMenengah.layer.borderWidth = 1.0
        ppmMinFaseMenengah.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMinFaseMenengah.clipsToBounds = true
        
        // Fase Vegetatif Menengah ppm Max
        ppmMaxFaseMenengah.layer.cornerRadius = 6
        ppmMaxFaseMenengah.layer.borderWidth = 1.0
        ppmMaxFaseMenengah.layer.borderColor = UIColor.primaryAccent.cgColor
        ppmMaxFaseMenengah.clipsToBounds = true
        
        // Fase Vegetatif Menengah ph Min
        phMinFaseMenengah.layer.cornerRadius = 6
        phMinFaseMenengah.layer.borderWidth = 1.0
        phMinFaseMenengah.layer.borderColor = UIColor.primaryAccent.cgColor
        phMinFaseMenengah.clipsToBounds = true
        
        // Fase Vegetatif Menengah ph Max
        phMaxFaseMenengah.layer.cornerRadius = 6
        phMaxFaseMenengah.layer.borderWidth = 1.0
        phMaxFaseMenengah.layer.borderColor = UIColor.primaryAccent.cgColor
        phMaxFaseMenengah.clipsToBounds = true
    }
    
}
