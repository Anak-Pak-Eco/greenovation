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
    
    private var editButton: UIBarButtonItem?
    
    private let viewModel = EditFormulaViewModel()
    private let plant: PlantModel
    
    init(plant: PlantModel) {
        self.plant = plant
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(plant: PlantModel(id: "", image_url: "", users_id: "", phases: [], name: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.successSaveFormula.bind { [unowned self] success in
            if success {
//                navigationController?.popToRootViewController(animated: true)
                editButton?.isEnabled = true
            }
        }
        viewModel.deletedSaveFormula.bind { [unowned self] deleted in
            if deleted {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        viewModel.loadingSaveFormula.bind { [unowned self] isLoading in
            editButtonItem.isEnabled = !isLoading
            deleteButton.isEnabled = !isLoading
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
        if viewModel.editMode {
            let anakanMinPpm = ppmMinFaseAnakan.text ?? ""
            let anakanMaxPpm = ppmMaxFaseAnakan.text ?? ""
            let anakanMinPh = phMinFaseAnakan.text ?? ""
            let anakanMaxPh = phMaxFaseAnakan.text ?? ""
            let vegetatifAwalMaxPpm = ppmMaxFaseAwal.text ?? ""
            let vegetatifAwalMinPpm = ppmMinFaseAwal.text ?? ""
            let vegetatifAwalMaxPh = phMaxFaseAwal.text ?? ""
            let vegetatifAwalMinPh = phMinFaseAwal.text ?? ""
            let vegetatifMenengahMaxPpm = ppmMaxFaseMenengah.text ?? ""
            let vegetatifMenengahMinPpm = ppmMinFaseMenengah.text ?? ""
            let vegetatifMenengahMaxPh = phMaxFaseMenengah.text ?? ""
            let vegetatifMenengahMinPh = phMinFaseMenengah.text ?? ""
            
            if anakanMinPh.isEmpty || anakanMaxPh.isEmpty || anakanMinPpm.isEmpty || anakanMaxPpm.isEmpty || vegetatifAwalMinPpm.isEmpty || vegetatifAwalMaxPpm.isEmpty || vegetatifAwalMinPh.isEmpty || vegetatifAwalMaxPh.isEmpty || vegetatifMenengahMinPh.isEmpty || vegetatifMenengahMaxPh.isEmpty || vegetatifMenengahMinPpm.isEmpty || vegetatifMenengahMaxPpm.isEmpty {
                
                let alertController = UIAlertController(
                    title: "Gagal Mengubah Tanaman",
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
                    name: plant.name,
                    plantId: plant.id,
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
                ppmMinFaseAwal.isEnabled = false
                ppmMaxFaseAwal.isEnabled = false
                phMinFaseAwal.isEnabled = false
                phMaxFaseAwal.isEnabled = false
                ppmMinFaseAnakan.isEnabled = false
                ppmMaxFaseAnakan.isEnabled = false
                phMinFaseAnakan.isEnabled = false
                phMaxFaseAnakan.isEnabled = false
                ppmMinFaseMenengah.isEnabled = false
                ppmMaxFaseMenengah.isEnabled = false
                phMinFaseMenengah.isEnabled = false
                phMaxFaseMenengah.isEnabled = false
                editButton?.title = "Edit"
                editButton?.isEnabled = false
            }
        } else {
            ppmMinFaseAwal.isEnabled = true
            ppmMaxFaseAwal.isEnabled = true
            phMinFaseAwal.isEnabled = true
            phMaxFaseAwal.isEnabled = true
            ppmMinFaseAnakan.isEnabled = true
            ppmMaxFaseAnakan.isEnabled = true
            phMinFaseAnakan.isEnabled = true
            phMaxFaseAnakan.isEnabled = true
            ppmMinFaseMenengah.isEnabled = true
            ppmMaxFaseMenengah.isEnabled = true
            phMinFaseMenengah.isEnabled = true
            phMaxFaseMenengah.isEnabled = true
            editButton?.title = String(localized: "simpan")
        }
        
        viewModel.editMode.toggle()
    }
    
    @IBAction func deleteButtonTapped() {
        let alertController = UIAlertController(
            title: "Hapus Formula",
            message: "Apakah kamu yakin ingin menghapus formula untuk tanaman \(plant.name)",
            preferredStyle: .alert
        )
        alertController.addAction(
            .init(
                title: "Hapus",
                style: .default,
                handler: { [unowned self] _ in
                    viewModel.deletePlant(id: plant.id)
                }
            )
        )
        alertController.addAction(
            .init(
                title: "Batal",
                style: .cancel,
                handler: { _ in
                    alertController.dismiss(animated: true)
                }
            )
        )
        self.present(alertController, animated: true)
    }
    
    private func setupToolbar() {
        title = String(localized: "pendaftaran-perangkat")
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.setLeftBarButton(backButton, animated: true)
        
        editButton = UIBarButtonItem(
            title: "Edit",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped)
        )
        navigationItem.setRightBarButton(editButton, animated: true)
    }
    
    private func setupUI() {
        // PPM Label
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
        
        plantName.text = plant.name
        
        let anakan = plant.phases.first(where: {$0.step == "anakan"})
        ppmMinFaseAnakan.text = String(describing: anakan?.min_ppm ?? 0)
        ppmMaxFaseAnakan.text = String(describing: anakan?.max_ppm ?? 0)
        phMinFaseAnakan.text = String(describing: anakan?.min_ph ?? 0)
        phMaxFaseAnakan.text = String(describing: anakan?.max_ph ?? 0)
        
        let awal = plant.phases.first(where: {$0.step == "vegetatif_awal"})
        ppmMinFaseAwal.text = String(describing: awal?.min_ppm ?? 0)
        ppmMaxFaseAwal.text = String(describing: awal?.max_ppm ?? 0)
        phMinFaseAwal.text = String(describing: awal?.min_ph ?? 0)
        phMaxFaseAwal.text = String(describing: awal?.max_ph ?? 0)
        
        let menengah = plant.phases.first(where: {$0.step == "vegetatif_awal"})
        ppmMinFaseMenengah.text = String(describing: menengah?.min_ppm ?? 0)
        ppmMaxFaseMenengah.text = String(describing: menengah?.max_ppm ?? 0)
        phMinFaseMenengah.text = String(describing: menengah?.min_ph ?? 0)
        phMaxFaseMenengah.text = String(describing: menengah?.max_ph ?? 0)
        
        // MARK: Disabled Text Field
        ppmMinFaseAwal.isEnabled = false
        ppmMaxFaseAwal.isEnabled = false
        phMinFaseAwal.isEnabled = false
        phMaxFaseAwal.isEnabled = false
        ppmMinFaseAnakan.isEnabled = false
        ppmMaxFaseAnakan.isEnabled = false
        phMinFaseAnakan.isEnabled = false
        phMaxFaseAnakan.isEnabled = false
        ppmMinFaseMenengah.isEnabled = false
        ppmMaxFaseMenengah.isEnabled = false
        phMinFaseMenengah.isEnabled = false
        phMaxFaseMenengah.isEnabled = false
    }
}
