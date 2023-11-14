//
//  RegisterFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class RegisterFormulaViewController: UIViewController {
    
    private let viewModel: RegisterFormulaViewModel
    
    @IBOutlet weak var anakanRecommendationLabel: UILabel!
    @IBOutlet weak var vegetatifMenengahRecommendationLabel: UILabel!
    @IBOutlet weak var vegetatifAwalRecommendationLabel: UILabel!
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
    
    let plant: PlantModel
    var isAddDevice = false
    
    init(plant: PlantModel) {
        self.plant = plant
        self.viewModel = RegisterFormulaViewModel(plant: plant)
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(plant: PlantModel(id: "", image_url: "", users_id: "", phases: [], name: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.successSaveFormula.bind { [unowned self] success in
            if success {
                if isAddDevice {
                    navigationController?.popViewController(animated: true)
                } else {
                    navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        viewModel.loadingSaveFormula.bind { [unowned self] isLoading in
            saveButton.isEnabled = !isLoading
        }
        viewModel.errorSaveFormula.bind { [unowned self] error in
            if !error.isEmpty {
                let alertController = UIAlertController(
                    title: "Login Gagal",
                    message: error,
                    preferredStyle: .alert
                )
                alertController.addAction(
                    .init(
                        title: "OK",
                        style: .destructive,
                        handler: { action in
                            alertController.dismiss(animated: true)
                        }
                    )
                )
                self.present(alertController, animated: true)
            }
        }
        setupToolbar()
        setupUI()
    }
    
    private func setupToolbar() {
        title = String(localized: "tambah-formula")
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        plantName.text = viewModel.plant.name
        
        let anakan = plant.phases.first { phase in
            phase.step == .anakan
        }
        
        let vegetatifAwal = plant.phases.first { phase in
            phase.step == .vegetatif_awal
        }
        
        let vegetatifMenengah = plant.phases.first { phase in
            phase.step == .vegetatif_menengah
        }
        
        anakanRecommendationLabel.text = "Rekomendari dari Greenovation:\nKepekatan Nutrisi: \(anakan?.min_ppm ?? 0)-\(anakan?.max_ppm ?? 0) & Tingkat pH: \(anakan?.min_ph ?? 0)-\(anakan?.max_ph ?? 0)"
        anakanRecommendationLabel.isHidden = plant.phases.isEmpty
        
        vegetatifAwalRecommendationLabel.text = "Rekomendari dari Greenovation:\nKepekatan Nutrisi: \(vegetatifAwal?.min_ppm ?? 0)-\(vegetatifAwal?.max_ppm ?? 0) & Tingkat pH: \(vegetatifAwal?.min_ph ?? 0)-\(vegetatifAwal?.max_ph ?? 0)"
        vegetatifAwalRecommendationLabel.isHidden = plant.phases.isEmpty
        
        vegetatifMenengahRecommendationLabel.text = "Rekomendari dari Greenovation:\nKepekatan Nutrisi: \(vegetatifMenengah?.min_ppm ?? 0)-\(vegetatifMenengah?.max_ppm ?? 0) & Tingkat pH: \(vegetatifMenengah?.min_ph ?? 0)-\(vegetatifMenengah?.max_ph ?? 0)"
        vegetatifMenengahRecommendationLabel.isHidden = plant.phases.isEmpty
        
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
        saveButton.layer.cornerRadius = 10
        saveButton.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let anakanMinPpm = faseAnakan_ppmMin.text ?? ""
        let anakanMaxPpm = faseAnakan_ppmMax.text ?? ""
        let anakanMinPh = faseAnakan_phMin.text ?? ""
        let anakanMaxPh = faseAnakan_phMax.text ?? ""
        let vegetatifAwalMaxPpm = faseVegetatifAwal_ppmMax.text ?? ""
        let vegetatifAwalMinPpm = faseVegetatifAwal_ppmMin.text ?? ""
        let vegetatifAwalMaxPh = faseVegetatifAwal_phMax.text ?? ""
        let vegetatifAwalMinPh = faseVegetatifAwal_phMin.text ?? ""
        let vegetatifMenengahMaxPpm = faseVegetatifMenengah_ppmMax.text ?? ""
        let vegetatifMenengahMinPpm = faseVegetatifMenengah_ppmMin.text ?? ""
        let vegetatifMenengahMaxPh = faseVegetatifMenengah_phMax.text ?? ""
        let vegetatifMenengahMinPh = faseVegetatifMenengah_phMin.text ?? ""
        
        if anakanMinPh.isEmpty || anakanMaxPh.isEmpty || anakanMinPpm.isEmpty || anakanMaxPpm.isEmpty || vegetatifAwalMinPpm.isEmpty || vegetatifAwalMaxPpm.isEmpty || vegetatifAwalMinPh.isEmpty || vegetatifAwalMaxPh.isEmpty || vegetatifMenengahMinPh.isEmpty || vegetatifMenengahMaxPh.isEmpty || vegetatifMenengahMinPpm.isEmpty || vegetatifMenengahMaxPpm.isEmpty {
            
            let alertController = UIAlertController(
                title: "Gagal Menambah Tanaman",
                message: "Isi semua data dengan benar",
                preferredStyle: .alert
            )
            alertController.addAction(
                .init(
                    title: "OK",
                    style: .destructive,
                    handler: { action in
                        alertController.dismiss(animated: true)
                    }
                )
            )
            self.present(alertController, animated: true)
        } else {
            viewModel.saveFormula(
                anakanMinPh: anakanMinPh,
                anakanMaxPh: anakanMaxPh,
                anakanMinPpm: anakanMinPpm,
                anakanMaxPpm: anakanMaxPpm,
                vegetatifAwalMinPh: vegetatifAwalMinPh,
                vegetatifAwalMaxPh: vegetatifAwalMaxPh,
                vegetatifAwalMinPpm: vegetatifAwalMinPpm,
                vegetatifAwalMaxPpm: vegetatifAwalMaxPpm,
                vegetatifMenengahMinPh: vegetatifMenengahMinPh,
                vegetatifMenengahMaxPh: vegetatifMenengahMaxPh,
                vegetatifMenengahMinPpm: vegetatifMenengahMinPpm,
                vegetatifMenengahMaxPpm: vegetatifMenengahMaxPpm
            )
        }
    }
}
