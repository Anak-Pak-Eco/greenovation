//
//  RegisterFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

protocol RegisterFormulaDelegate {
    func onSubmit()
}

class RegisterFormulaViewController: UIViewController, RegisterFormulaDelegate {
    
    private let viewModel: RegisterFormulaViewModel
    
    @IBOutlet weak var registerFormulaTableView: UITableView!
    private var anakanPhaseCell: AnakanPhaseTableViewCell?
    private var awalPhaseCell: AwalPhaseTableViewCell?
    private var menengahPhaseCell: MenengahPhaseTableViewCell?
    private var submitButtonCell: SubmitButtonTableViewCell?
    
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
            submitButtonCell?.submitButton?.isEnabled = !isLoading
        }
        viewModel.errorSaveFormula.bind { [unowned self] error in
            if !error.isEmpty {
                let alertController = UIAlertController(
                    title: "Gagal Menambah Formula",
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
        registerFormulaTableView.contentInset = contentInsets
        registerFormulaTableView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        registerFormulaTableView.contentInset = contentInsets
        registerFormulaTableView.scrollIndicatorInsets = contentInsets
    }
    
    private func setupToolbar() {
        title = String(localized: "add-formula")
        
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
        registerFormulaTableView.register(
            UINib(nibName: "TypeOfPlantTableViewCell", bundle: nil),
            forCellReuseIdentifier: "TypeOfPlantTableViewCell"
        )
        registerFormulaTableView.register(
            UINib(nibName: "AnakanPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AnakanPhaseTableViewCell"
        )
        registerFormulaTableView.register(
            UINib(nibName: "AwalPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "AwalPhaseTableViewCell"
        )
        registerFormulaTableView.register(
            UINib(nibName: "MenengahPhaseTableViewCell", bundle: nil),
            forCellReuseIdentifier: "MenengahPhaseTableViewCell"
        )
        registerFormulaTableView.register(
            UINib(nibName: "SubmitButtonTableViewCell", bundle: nil),
            forCellReuseIdentifier: "SubmitButtonTableViewCell"
        )
        registerFormulaTableView.allowsSelection = false
        registerFormulaTableView.separatorStyle = .none
        registerFormulaTableView.dataSource = self
        registerFormulaTableView.delegate = self
        registerFormulaTableView.reloadData()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func onSubmit() {
        let anakanMaxPpm = anakanPhaseCell?.maxPpmTextField.text ?? ""
        let anakanMinPpm = anakanPhaseCell?.minPpmTextField.text ?? ""
        let anakanMaxPh = anakanPhaseCell?.maxPhTextField.text ?? ""
        let anakanMinPh = anakanPhaseCell?.minPhTextField.text ?? ""
        let vegetatifAwalMaxPpm = awalPhaseCell?.maxPpmTextField.text ?? ""
        let vegetatifAwalMinPpm = awalPhaseCell?.minPpmTextField.text ?? ""
        let vegetatifAwalMaxPh = awalPhaseCell?.maxPhTextField.text ?? ""
        let vegetatifAwalMinPh = awalPhaseCell?.minPhTextField.text ?? ""
        let vegetatifMenengahMaxPpm = menengahPhaseCell?.maxPpmTextField.text ?? ""
        let vegetatifMenengahMinPpm = menengahPhaseCell?.minPpmTextField.text ?? ""
        let vegetatifMenengahMaxPh = menengahPhaseCell?.maxPhTextField.text ?? ""
        let vegetatifMenengahMinPh = menengahPhaseCell?.minPhTextField.text ?? ""

        if anakanMinPh.isEmpty || 
            anakanMaxPh.isEmpty ||
            anakanMinPpm.isEmpty ||
            anakanMaxPpm.isEmpty ||
            vegetatifAwalMinPpm.isEmpty ||
            vegetatifAwalMaxPpm.isEmpty || 
            vegetatifAwalMinPh.isEmpty ||
            vegetatifAwalMaxPh.isEmpty ||
            vegetatifMenengahMinPh.isEmpty ||
            vegetatifMenengahMaxPh.isEmpty ||
            vegetatifMenengahMinPpm.isEmpty ||
            vegetatifMenengahMaxPpm.isEmpty {
            
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
                anakanMinPh: anakanMinPh.replacingOccurrences(of: ",", with: "."),
                anakanMaxPh: anakanMaxPh.replacingOccurrences(of: ",", with: "."),
                anakanMinPpm: anakanMinPpm.replacingOccurrences(of: ",", with: "."),
                anakanMaxPpm: anakanMaxPpm.replacingOccurrences(of: ",", with: "."),
                vegetatifAwalMinPh: vegetatifAwalMinPh.replacingOccurrences(of: ",", with: "."),
                vegetatifAwalMaxPh: vegetatifAwalMaxPh.replacingOccurrences(of: ",", with: "."),
                vegetatifAwalMinPpm: vegetatifAwalMinPpm.replacingOccurrences(of: ",", with: "."),
                vegetatifAwalMaxPpm: vegetatifAwalMaxPpm.replacingOccurrences(of: ",", with: "."),
                vegetatifMenengahMinPh: vegetatifMenengahMinPh.replacingOccurrences(of: ",", with: "."),
                vegetatifMenengahMaxPh: vegetatifMenengahMaxPh.replacingOccurrences(of: ",", with: "."),
                vegetatifMenengahMinPpm: vegetatifMenengahMinPpm.replacingOccurrences(of: ",", with: "."),
                vegetatifMenengahMaxPpm: vegetatifMenengahMaxPpm.replacingOccurrences(of: ",", with: ".")
            )
        }
    }
}

extension RegisterFormulaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            // Type of Formula Section
            let cell = registerFormulaTableView.dequeueReusableCell(
                withIdentifier: "TypeOfPlantTableViewCell",
                for: indexPath
            ) as! TypeOfPlantTableViewCell
            
            cell.setPlantType(plant.name)
            
            return cell
        case 1:
            // Anakan Phase Section
            anakanPhaseCell = registerFormulaTableView.dequeueReusableCell(
                withIdentifier: "AnakanPhaseTableViewCell",
                for: indexPath
            ) as? AnakanPhaseTableViewCell
            
            if let anakan = plant.phases.first(where: { $0.step == .anakan }) {
                anakanPhaseCell?.setRecommendation(
                    String(localized: "recommendation_label \(anakan.min_ppm.clean) \(anakan.max_ppm.clean) \(anakan.min_ph.clean) \(anakan.max_ph.clean)"),
                    isHidden: plant.phases.isEmpty
                )
            }
            
            return anakanPhaseCell!
        case 2:
            // Awal Phase Section
            awalPhaseCell = registerFormulaTableView.dequeueReusableCell(
                withIdentifier: "AwalPhaseTableViewCell",
                for: indexPath
            ) as? AwalPhaseTableViewCell
            
            if let awal = plant.phases.first(where: { $0.step == .vegetatif_awal }) {
                awalPhaseCell?.setRecommendation(
                    String(localized: "recommendation_label \(awal.min_ppm.clean) \(awal.max_ppm.clean) \(awal.min_ph.clean) \(awal.max_ph.clean)"),
                    isHidden: plant.phases.isEmpty
                )
            }
            
            return awalPhaseCell!
        case 3:
            // Menengah Phase Section
            menengahPhaseCell = registerFormulaTableView.dequeueReusableCell(
                withIdentifier: "MenengahPhaseTableViewCell",
                for: indexPath
            ) as? MenengahPhaseTableViewCell
            
            if let menengah = plant.phases.first(where: { $0.step == .vegetatif_menengah }) {
                menengahPhaseCell?.setRecommendation(
                    String(localized: "recommendation_label \(menengah.min_ppm.clean) \(menengah.max_ppm.clean) \(menengah.min_ph.clean) \(menengah.max_ph.clean)"),
                    isHidden: plant.phases.isEmpty
                )
            }
            
            return menengahPhaseCell!
        case 4:
            // Anakan Phase Section
            submitButtonCell = registerFormulaTableView.dequeueReusableCell(
                withIdentifier: "SubmitButtonTableViewCell",
                for: indexPath
            ) as? SubmitButtonTableViewCell
            
            submitButtonCell?.selectionStyle = .none
            submitButtonCell?.delegate = self
            
            return submitButtonCell!
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
}
