//
//  AddDeviceV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

protocol AddDeviceGrowthStepDelegate {
    func onPhaseSelected(_ phase: PlantModel.PlantPhaseModel)
}

class AddDeviceV2ViewController: UIViewController {
    
    @IBOutlet var deviceNameTextField: UITextField!
    @IBOutlet var plantTextField: UITextField!
    @IBOutlet var growthStepButton: UIButton!
    @IBOutlet var growthStep: LocalizableLabel!
    @IBOutlet weak var plantTableView: UITableView!
    @IBOutlet var saveButton: LocalizableButton!
    
    private let viewModel = AddDeviceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.successFetchPlants.bind { [unowned self] isSuccess in
            if isSuccess {
                plantTableView.reloadData()
            }
        }
        viewModel.loadingAddDevice.bind { [unowned self] isLoading in
            deviceNameTextField.isEnabled = !isLoading
            plantTextField.isEnabled = !isLoading
            saveButton.isEnabled = !isLoading
        }
        viewModel.errorFetchPlants.bind { [unowned self] errorMessage in
            if !errorMessage.isEmpty {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        viewModel.updateSelectedPlant.bind { [unowned self] plant in
            if let plant = plant {
                view.endEditing(true)
                plantTableView.isHidden = true
                plantTextField.text = plant.name
                plantTextField.isEnabled = false
                growthStepButton.isEnabled = true
            }
        }
        viewModel.updateSelectedPhase.bind { [unowned self] phase in
            if let phase = phase {
                growthStep.text = phase.step.getText()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [unowned self] in
                    openGrowthStepBottomSheet(plant: viewModel.selectedPlant, selectedPhase: phase)
                }
            }
        }
        setupToolbar()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getPlants()
    }
    
    private func setupToolbar() {
        title = String(localized: "device-register")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.forceUpdateNavbar()
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
    
    @objc func saveButtonTapped() {
        
    }
    
    @IBAction func onGrowthStepButtonClicked(_ sender: UIButton) {
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
        vc.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *), let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(vc, animated: true, completion: nil)
    }
    
    private func setupUI() {
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
        
        // MARK: Device Name Text Field
        deviceNameTextField.placeholder = String(localized: "device-name")
        deviceNameTextField.layer.borderWidth = 0.3
        deviceNameTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
        deviceNameTextField.layer.cornerRadius = 10
        let deviceNamePaddingView = UIView(
            frame: CGRect(
                x: 0, y: 0,
                width: 10, height: deviceNameTextField.frame.size.height
            )
        )
        deviceNameTextField.leftView = deviceNamePaddingView
        deviceNameTextField.leftViewMode = .always
        
        // MARK: Growth Step Button
        growthStepButton.layer.borderWidth = 0.3
        growthStepButton.layer.borderColor = UIColor.secondaryAccent.cgColor
        growthStepButton.layer.cornerRadius = 10
        growthStepButton.clipsToBounds = true
        growthStepButton.isEnabled = false
        
        // MARK: Save Button
        saveButton.layer.borderWidth = 1.0
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderColor = UIColor.primaryAccent.cgColor
        saveButton.clipsToBounds = true
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        // MARK: Plant Text Field
        plantTextField.placeholder = String(localized: "cari-tanaman")
        plantTextField.layer.borderWidth = 0.3
        plantTextField.layer.cornerRadius = 10
        plantTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
        plantTextField.delegate = self
        
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: plantTextField.frame.size.height
            )
        )
        plantTextField.leftView = paddingView
        plantTextField.leftViewMode = .always
        
        let imageWidth = 24
        plantTextField.rightViewMode = .always
        let buttonImage = UIButton(frame: CGRect(
            x: 2,
            y: 0,
            width: 24,
            height: plantTextField.frame.height)
        )
        let image = UIImage(systemName: "magnifyingglass")
        buttonImage.setImage(image, for: .normal)
        buttonImage.contentMode = .scaleAspectFit
        buttonImage.tintColor = UIColor.secondaryAccent
        buttonImage.addTarget(
            self,
            action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside
        )
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(plantTextField.frame.height))
        )
        containerView.addSubview(buttonImage)
        plantTextField.rightView = containerView
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        viewModel.searchData(query: plantTextField.text ?? "")
        plantTextField.endEditing(true)
        plantTableView.isHidden = false
    }
}

extension AddDeviceV2ViewController: AddDeviceGrowthStepDelegate {
    func onPhaseSelected(_ phase: PlantModel.PlantPhaseModel) {
        viewModel.updateSelectedPhase(phase)
    }
}

extension AddDeviceV2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.searchData(query: textField.text ?? "")
        plantTableView.isHidden = false
        textField.resignFirstResponder()
        return true
    }
}

extension AddDeviceV2ViewController: UITableViewDelegate, UITableViewDataSource {
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
                        name: plantTextField.text ?? ""
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
                viewModel.updateSelectedPlant(plant)
            }
            
            return cell
        }
    }
}
