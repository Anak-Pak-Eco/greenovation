//
//  RegisterFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class RegisterFormulaViewController: UIViewController {
    
    @IBOutlet var plantName: UILabel!
    @IBOutlet var faseAnakan_ppmMin: UITextField!
    @IBOutlet var faseAnakan_ppmMax: UITextField!
    @IBOutlet var faseAnakan_phMin: UITextField!
    @IBOutlet var faseAnakan_phMax: UITextField!
    @IBOutlet var faseVegetatifAwal_ppmMin: UITextField!
    @IBOutlet var faseVegetatifAwal_ppmMax: UITextField!
    @IBOutlet var faseVegetatifAwal_phMin: UITextField!
    @IBOutlet var faseVegetatifAwal_phMax: UITextField!
    @IBOutlet var faseVegetatifMenengah_ppmMin: UITextField!
    @IBOutlet var faseVegetatifMenengah_ppmMax: UITextField!
    @IBOutlet var faseVegetatifMenengah_phMin: UITextField!
    @IBOutlet var faseVegetatifMenengah_phMax: UITextField!
    @IBOutlet var saveButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupToolbar()
        style()
    }
    
    private func setupToolbar() {
        self.title = String(localized: "tambah-formula")
        
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
    
    private func style() {
        // Fase Anakan ppm Min
        faseAnakan_ppmMin.layer.cornerRadius = 6
        faseAnakan_ppmMin.layer.borderWidth = 1.0
        faseAnakan_ppmMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseAnakan_ppmMin.clipsToBounds = true
        
        // Fase Anakan ppm Max
        faseAnakan_ppmMax.layer.cornerRadius = 6
        faseAnakan_ppmMax.layer.borderWidth = 1.0
        faseAnakan_ppmMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseAnakan_ppmMax.clipsToBounds = true
        
        // Fase Anakan ph Min
        faseAnakan_phMin.layer.cornerRadius = 6
        faseAnakan_phMin.layer.borderWidth = 1.0
        faseAnakan_phMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseAnakan_phMin.clipsToBounds = true
        
        // Fase Anakan ph Max
        faseAnakan_phMax.layer.cornerRadius = 6
        faseAnakan_phMax.layer.borderWidth = 1.0
        faseAnakan_phMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseAnakan_phMax.clipsToBounds = true
        
        // Fase Vegetatif Awal ppm Min
        faseVegetatifAwal_ppmMin.layer.cornerRadius = 6
        faseVegetatifAwal_ppmMin.layer.borderWidth = 1.0
        faseVegetatifAwal_ppmMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifAwal_ppmMin.clipsToBounds = true
        
        // Fase Vegetatif Awal ppm Max
        faseVegetatifAwal_ppmMax.layer.cornerRadius = 6
        faseVegetatifAwal_ppmMax.layer.borderWidth = 1.0
        faseVegetatifAwal_ppmMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifAwal_ppmMax.clipsToBounds = true
        
        // Fase Vegetatif Awal ph Min
        faseVegetatifAwal_phMin.layer.cornerRadius = 6
        faseVegetatifAwal_phMin.layer.borderWidth = 1.0
        faseVegetatifAwal_phMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifAwal_phMin.clipsToBounds = true
        
        // Fase Vegetatif Awal ph Max
        faseVegetatifAwal_phMax.layer.cornerRadius = 6
        faseVegetatifAwal_phMax.layer.borderWidth = 1.0
        faseVegetatifAwal_phMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifAwal_phMax.clipsToBounds = true
        
        // Fase Vegetatif Menengah ppm Min
        faseVegetatifMenengah_ppmMin.layer.cornerRadius = 6
        faseVegetatifMenengah_ppmMin.layer.borderWidth = 1.0
        faseVegetatifMenengah_ppmMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifMenengah_ppmMin.clipsToBounds = true
        
        // Fase Vegetatif Menengah ppm Max
        faseVegetatifMenengah_ppmMax.layer.cornerRadius = 6
        faseVegetatifMenengah_ppmMax.layer.borderWidth = 1.0
        faseVegetatifMenengah_ppmMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifMenengah_ppmMax.clipsToBounds = true
        
        // Fase Vegetatif Menengah ph Min
        faseVegetatifMenengah_phMin.layer.cornerRadius = 6
        faseVegetatifMenengah_phMin.layer.borderWidth = 1.0
        faseVegetatifMenengah_phMin.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifMenengah_phMin.clipsToBounds = true
        
        // Fase Vegetatif Menengah ph Max
        faseVegetatifMenengah_phMax.layer.cornerRadius = 6
        faseVegetatifMenengah_phMax.layer.borderWidth = 1.0
        faseVegetatifMenengah_phMax.layer.borderColor = UIColor.primaryAccent.cgColor
        faseVegetatifMenengah_phMax.clipsToBounds = true
        
        // Save Button
        saveButton.layer.borderWidth = 1.0
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.layer.cornerRadius = 10.0
        saveButton.clipsToBounds = true
    }
    
}
