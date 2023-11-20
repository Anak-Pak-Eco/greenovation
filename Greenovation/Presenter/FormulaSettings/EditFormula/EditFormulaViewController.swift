//
//  EditFormulaV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 10/11/23.
//

import UIKit

protocol EditFormulaDelegate {
    func onDeleteFormulaClicked()
}

class EditFormulaViewController: UIViewController, EditFormulaDelegate {
    
    @IBOutlet weak var editFormulaTableView: UITableView!
    private var anakanPhaseCell: AnakanPhaseTableViewCell?
    private var awalPhaseCell: AwalPhaseTableViewCell?
    private var menengahPhaseCell: MenengahPhaseTableViewCell?
    private var deleteFormulaButtonCell: DeleteFormulaButtonCell?
    private var editButton: UIBarButtonItem?
    private let viewModel: EditFormulaViewModel
    
    init(plant: PlantModel) {
        self.viewModel = EditFormulaViewModel(plant: plant)
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(plant: PlantModel(id: "", image_url: "", users_id: "", phases: [], name: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.successSaveFormula.bind { [unowned self] success in
            if success {
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
            deleteFormulaButtonCell?.deleteFormulaButton.isEnabled = !isLoading
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        editFormulaTableView.contentInset = contentInsets
        editFormulaTableView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        editFormulaTableView.contentInset = contentInsets
        editFormulaTableView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonTapped() {
        if viewModel.editMode {
            let anakanMinPpm = anakanPhaseCell?.minPpmTextField.text ?? ""
            let anakanMaxPpm = anakanPhaseCell?.maxPpmTextField.text ?? ""
            let anakanMinPh = anakanPhaseCell?.minPhTextField.text ?? ""
            let anakanMaxPh = anakanPhaseCell?.maxPhTextField.text ?? ""
            let vegetatifAwalMaxPpm = awalPhaseCell?.maxPpmTextField.text ?? ""
            let vegetatifAwalMinPpm = awalPhaseCell?.minPpmTextField.text ?? ""
            let vegetatifAwalMaxPh = awalPhaseCell?.maxPhTextField.text ?? ""
            let vegetatifAwalMinPh = awalPhaseCell?.minPhTextField.text ?? ""
            let vegetatifMenengahMaxPpm = menengahPhaseCell?.maxPpmTextField.text ?? ""
            let vegetatifMenengahMinPpm = menengahPhaseCell?.minPpmTextField.text ?? ""
            let vegetatifMenengahMaxPh = menengahPhaseCell?.maxPhTextField.text ?? ""
            let vegetatifMenengahMinPh = menengahPhaseCell?.minPhTextField.text ?? ""
            
            if anakanMinPh.isEmpty 
                || anakanMaxPh.isEmpty
                || anakanMinPpm.isEmpty
                || anakanMaxPpm.isEmpty
                || vegetatifAwalMinPpm.isEmpty
                || vegetatifAwalMaxPpm.isEmpty
                || vegetatifAwalMinPh.isEmpty
                || vegetatifAwalMaxPh.isEmpty
                || vegetatifMenengahMinPh.isEmpty
                || vegetatifMenengahMaxPh.isEmpty
                || vegetatifMenengahMinPpm.isEmpty
                || vegetatifMenengahMaxPpm.isEmpty {
                
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
                    name: viewModel.plant.name,
                    plantId: viewModel.plant.id,
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
                editButton?.title = "Edit"
                editButton?.isEnabled = false
            }
        } else {
            editButton?.title = String(localized: "save")
        }
        
        viewModel.editMode.toggle()
        editFormulaTableView.reloadData()
    }
    
    private func setupToolbar() {
        title = String(localized: "device-register")
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
        editFormulaTableView.register(
            UINib(nibName: "TypeOfPlantTableViewCell", bundle: nil),
            forCellReuseIdentifier: "TypeOfPlantTableViewCell"
        )
        editFormulaTableView.register(
            UINib(nibName: "AnakanPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AnakanPhaseTableViewCell"
        )
        editFormulaTableView.register(
            UINib(nibName: "AwalPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AwalPhaseTableViewCell"
        )
        editFormulaTableView.register(
            UINib(nibName: "MenengahPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenengahPhaseTableViewCell"
        )
        editFormulaTableView.register(
            UINib(nibName: "DeleteFormulaButtonCell", bundle: nil),
            forCellReuseIdentifier: "DeleteFormulaButtonCell"
        )
        editFormulaTableView.allowsSelection = false
        editFormulaTableView.separatorStyle = .none
        editFormulaTableView.dataSource = self
        editFormulaTableView.delegate = self
        editFormulaTableView.reloadData()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func onDeleteFormulaClicked() {
        let alertController = UIAlertController(
            title: "Hapus Formula",
            message: "Apakah kamu yakin ingin menghapus formula untuk tanaman \(viewModel.plant.name)",
            preferredStyle: .alert
        )
        alertController.addAction(
            .init(
                title: "Hapus",
                style: .default,
                handler: { [unowned self] _ in
                    viewModel.deletePlant(id: viewModel.plant.id)
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
}

extension EditFormulaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // Type of Formula Section
            let cell = editFormulaTableView.dequeueReusableCell(
                withIdentifier: "TypeOfPlantTableViewCell",
                for: indexPath
            ) as! TypeOfPlantTableViewCell
            
            cell.setPlantType(viewModel.plant.name)
            
            return cell
        case 1:
            // Anakan Phase Section
            anakanPhaseCell = editFormulaTableView.dequeueReusableCell(
                withIdentifier: "AnakanPhaseTableViewCell",
                for: indexPath
            ) as? AnakanPhaseTableViewCell
            
            if let anakan = viewModel.plant.phases.first(where: { $0.step == .anakan }) {
                anakanPhaseCell?.setup(isEditingMode: viewModel.editMode, phase: anakan)
            }
            
            return anakanPhaseCell!
        case 2:
            // Awal Phase Section
            awalPhaseCell = editFormulaTableView.dequeueReusableCell(
                withIdentifier: "AwalPhaseTableViewCell",
                for: indexPath
            ) as? AwalPhaseTableViewCell
            
            if let awal = viewModel.plant.phases.first(where: { $0.step == .vegetatif_awal }) {
                awalPhaseCell?.setup(isEditingMode: viewModel.editMode, phase: awal)
            }
            
            return awalPhaseCell!
        case 3:
            // Menengah Phase Section
            menengahPhaseCell = editFormulaTableView.dequeueReusableCell(
                withIdentifier: "MenengahPhaseTableViewCell",
                for: indexPath
            ) as? MenengahPhaseTableViewCell
            
            if let menengah = viewModel.plant.phases.first(where: { $0.step == .vegetatif_menengah }) {
                menengahPhaseCell?.setup(isEditingMode: viewModel.editMode, phase: menengah)
            }
            
            return menengahPhaseCell!
        case 4:
            // Anakan Phase Section
            deleteFormulaButtonCell = editFormulaTableView.dequeueReusableCell(
                withIdentifier: "DeleteFormulaButtonCell",
                for: indexPath
            ) as? DeleteFormulaButtonCell
            
            deleteFormulaButtonCell?.selectionStyle = .none
            deleteFormulaButtonCell?.delegate = self
            
            return deleteFormulaButtonCell!
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
