//
//  AddDeviceV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

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
            growthStepButton.isEnabled = !isLoading
            saveButton.isEnabled = !isLoading
        }
        viewModel.errorFetchPlants.bind { [unowned self] errorMessage in
            if !errorMessage.isEmpty {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        setupToolbar()
        setupUI()
        viewModel.getPlants()
    }
    
    private func setupToolbar() {
        title = String(localized: "pendaftaran-perangkat")
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
    
    @objc func growthStepTapped() {
        let vc = DontHavePlantFormulaViewController()
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
        
        // MARK: Plant Name Text Field
//        plantTextField.placeholder = String(localized: "device-name")
//        plantTextField.layer.borderWidth = 0.3
//        plantTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
//        plantTextField.layer.cornerRadius = 10
//        let plantTextFieldPaddingView = UIView(
//            frame: CGRect(
//                x: 0, y: 0, 
//                width: 10, height: plantTextField.frame.size.height
//            )
//        )
//        plantTextField.leftView = plantTextFieldPaddingView
//        plantTextField.leftViewMode = .always
        
        // MARK: Growth Step Button
        growthStepButton.layer.borderWidth = 0.3
        growthStepButton.layer.borderColor = UIColor.secondaryAccent.cgColor
        growthStepButton.layer.cornerRadius = 10
        growthStepButton.clipsToBounds = true
        growthStepButton.addTarget(self, action: #selector(growthStepTapped), for: .touchUpInside)
        
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
                let viewController = RegisterFormulaViewController(plant: plant)
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            return cell
        }
    }
}
