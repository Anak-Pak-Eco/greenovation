//
//  EditDevicePlantViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 21/11/23.
//

import UIKit

class EditDevicePlantViewController: UIViewController {
    
    @IBOutlet weak var plantTypeLabel: LocalizableLabel!
    @IBOutlet weak var plantTypeTextField: UITextField!
    @IBOutlet weak var phaseLabel: LocalizableLabel!
    @IBOutlet weak var phaseTextField: LocalizableLabel!
    @IBOutlet weak var ppmTitleLabel: LocalizableLabel!
    @IBOutlet weak var phTitleLabel: LocalizableLabel!
    @IBOutlet weak var growthStepButton: UIButton!
    @IBOutlet weak var phaseView: UIView!
    @IBOutlet weak var ppmLabel: UILabel!
    @IBOutlet weak var phLabel: UILabel!
    @IBOutlet weak var plantTableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var phaseViewTitleLabel: LocalizableLabel!
    
    private let viewModel = EditDevicePlantViewModel()
    
    let device: DeviceModel
    
    init(device: DeviceModel) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(device: .init(id: "", name: "", currentPh: 0, currentSteps: "", currentPpm: 0, plant: .init(max_ph: 0, min_ph: 0, max_ppm: 0, min_ppm: 0, name: "", image_url: "", id: ""), usersId: "", status: "", serial_number: ""))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupToolbar()
        setupUI()
    }
    
    private func setupUI() {
        plantTypeTextField.text = device.plant.name
        plantTypeTextField.delegate = self
        
        phaseView.isHidden = true
        phaseView.layer.cornerRadius = 10
        
        // MARK: Plants Table View
        plantTableView.register(
            UINib(nibName: "PlantSearchItemCell", bundle: nil),
            forCellReuseIdentifier: "PlantSearchItemCell"
        )
        plantTableView.register(
            UINib(nibName: "EmptyPlantItemCell", bundle: nil),
            forCellReuseIdentifier: "EmptyPlantItemCell"
        )
        plantTableView.delegate = self
        plantTableView.dataSource = self
        plantTableView.isHidden = true
        
        // MARK: Growth Step Button
        growthStepButton.layer.borderWidth = 0.3
        growthStepButton.layer.borderColor = UIColor.secondaryAccent.cgColor
        growthStepButton.layer.cornerRadius = 10
        growthStepButton.clipsToBounds = true
        growthStepButton.isEnabled = false
        
        // MARK: Save Button
        saveButton.layer.borderWidth = 1
        saveButton.layer.cornerRadius = 10
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.clipsToBounds = true
        
        // MARK: Plant Text Field
        plantTypeTextField.placeholder = String(localized: "cari-tanaman")
        plantTypeTextField.layer.borderWidth = 0.3
        plantTypeTextField.layer.cornerRadius = 10
        plantTypeTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
        plantTypeTextField.delegate = self
        
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: plantTypeTextField.frame.size.height
            )
        )
        plantTypeTextField.leftView = paddingView
        plantTypeTextField.leftViewMode = .always
        
        let imageWidth = 24
        plantTypeTextField.rightViewMode = .always
        let buttonImage = UIButton(frame: CGRect(
            x: 2,
            y: 0,
            width: 24,
            height: plantTypeTextField.frame.height)
        )
        let image = UIImage(systemName: "magnifyingglass")
        buttonImage.setImage(image, for: .normal)
        buttonImage.contentMode = .scaleAspectFit
        buttonImage.tintColor = UIColor.secondaryAccent
        buttonImage.addTarget(
            self,
            action: #selector(onSearchButtonClicked(_:)), for: .editingDidBegin
        )
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(plantTypeTextField.frame.height))
        )
        containerView.addSubview(buttonImage)
        plantTypeTextField.rightView = containerView
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        viewModel.searchData(query: plantTypeTextField.text ?? "")
        plantTypeTextField.endEditing(true)
        plantTableView.isHidden = plantTypeTextField.text?.isEmpty == true
    }
    
    private func setupToolbar() {
        title = String(localized: "update")
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "DMSans-SemiBold", size: 17)!,
            .foregroundColor: UIColor.onPrimaryFixed
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonClicked(_:))
        )
    }
    
    @objc func onBackButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupObserver() {
        viewModel.successFetchPlants.bind { [unowned self] isSuccess in
            if isSuccess {
                if let plant = viewModel.plants.first(where: { $0.id == device.plant.id }) {
                    viewModel.updateSelectedPlant(plant)
                    if let phase = plant.phases.first(where: { $0.step.rawValue == device.currentSteps }) {
                        viewModel.updateSelectedPhase(phase)
                    }
                }
                plantTableView.reloadData()
            }
        }
        
        viewModel.errorFetchPlants.bind { [unowned self] errorMessage in
            if !errorMessage.isEmpty {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        
        viewModel.updateSelectedPlant.bind { [unowned self] plant in
            if let plant = plant {
                plantTableView.isHidden = true
                growthStepButton.isEnabled = true
                phaseTextField.text = ""
                phaseView.isHidden = true
                viewModel.updateSelectedPhase(nil)
            }
        }
        
        viewModel.updateSelectedPhase.bind { [unowned self] phase in
            if let phase = phase {
                phaseTextField.text = phase.step.getText()
                onFormulaSelected()
            }
        }
        
        viewModel.loadingAddDevice.bind { [unowned self] isLoading in
            saveButton.isEnabled = !isLoading
            growthStepButton.isEnabled = !isLoading
            plantTypeTextField.isEnabled = !isLoading
        }
        
        viewModel.successAddDevice.bind { [unowned self] isSuccess in
            if isSuccess {
                let alertController = UIAlertController(
                    title: String(localized: "success-title"),
                    message: String(localized: "update-device-success"),
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
        
        viewModel.errorFetchPlants.bind { error in
            if !error.isEmpty {
                let alertController = UIAlertController(
                    title: String(localized: "error-title"),
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
    }
    @IBAction func saveButtonClicked(_ sender: Any) {
        viewModel.saveDevice(device: device, name: device.name)
    }
    
    @IBAction func growthStepButtonClicked(_ sender: Any) {
        if let chosenPlants = viewModel.selectedPlant {
            let vc = GrowthStepBottomSheetViewController(plant: chosenPlants, chosenPhase: viewModel.selectedPhase)
            vc.delegate = self
            vc.modalPresentationStyle = .pageSheet
            if #available(iOS 15.0, *), let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium()]
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    private func openGrowthStepBottomSheet(plant: PlantModel?, selectedPhase: PlantModel.PlantPhaseModel?) {
        guard let plant = plant, let selectedPhase = selectedPhase else { return }
        let vc = HavePlantFormulaViewController(plant: plant, phase: selectedPhase)
        vc.delegate = self
        vc.modalPresentationStyle = .pageSheet
        vc.presentationController?.delegate = self
        vc.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 292)
        if #available(iOS 15.0, *), let sheet = vc.sheetPresentationController {
            if #available(iOS 16.0, *) {
                let fraction = UISheetPresentationController.Detent.custom { context in
                    292
                }
                sheet.detents = [fraction]
            }
        }
        present(vc, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension EditDevicePlantViewController: AddDeviceGrowthStepDelegate, AddDevicePlantFormulaDelegate, UIAdaptivePresentationControllerDelegate {
    func onFormulaSelected() {
        if let phase = viewModel.selectedPhase {
            phaseView.isHidden = false
            phaseViewTitleLabel.text = "Formula Tanaman Fase \(phase.step.getText())"
            ppmLabel.text = "\(phase.min_ppm.clean) - \(phase.max_ppm.clean)"
            phLabel.text = "\(phase.min_ph.clean) - \(phase.max_ph.clean)"
        }
    }
    
    func onPhaseSelected(_ phase: PlantModel.PlantPhaseModel) {
        viewModel.updateSelectedPhase(phase)
    }
}

extension EditDevicePlantViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.searchData(query: textField.text ?? "")
        plantTableView.isHidden = textField.text?.isEmpty == true
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        viewModel.searchData(query: updatedText)
        plantTableView.isHidden = updatedText.isEmpty
        phaseTextField.text = ""
        phaseView.isHidden = true
        viewModel.updateSelectedPhase(nil)
        
        return true
    }
}

extension EditDevicePlantViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedPlants.count == 0 ? 1 : viewModel.searchedPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searchedPlants.isEmpty {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "EmptyPlantItemCell",
                for: indexPath
            ) as! EmptyPlantItemCell
            
            cell.didClickAddButton = { [unowned self] in
                let viewController = RegisterFormulaViewController(
                    plant: PlantModel(
                        id: "",
                        image_url: "",
                        users_id: "",
                        phases: [],
                        name: plantTypeTextField.text ?? ""
                    )
                )
                viewController.isAddDevice = true
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "PlantSearchItemCell",
                for: indexPath
            ) as! PlantSearchItemCell
            
            let plant = viewModel.searchedPlants[indexPath.row]
            
            cell.setup(plant: plant)
            cell.didSelectPlant = { [unowned self] in
                plantTypeTextField.text = plant.name
                viewModel.updateSelectedPlant(plant)
            }
            
            return cell
        }
    }
}

extension EditDevicePlantViewController  {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        viewModel.getPlants(query: plantTypeTextField.text ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
