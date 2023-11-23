//
//  EditDeviceV2ViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 09/11/23.
//

import UIKit

class EditDeviceViewController: UIViewController {
    
    @IBOutlet weak var sensorLabel: UILabel!
    @IBOutlet weak var sensorSwitch: UISwitch!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let device: DeviceModel
    private let viewModel = EditDeviceViewModel()
    
    init(device: DeviceModel) {
        self.device = device
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(device: .init(id: "", name: "", currentPh: 0, currentSteps: "", currentPpm: 0, plant: .init(max_ph: 0, min_ph: 0, max_ppm: 0, min_ppm: 0, name: "test", image_url: "image_url", id: "test"), usersId: "test", status: "test", serial_number: ""))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupUI()
        setupToolbar()
    }
    
    private func setupObserver() {
        viewModel.loadingSaveDevice.bind { [unowned self] isLoading in
            deleteButton.isEnabled = !isLoading
            saveButton.isEnabled = !isLoading
            deviceNameTextField.isEnabled = !isLoading
            sensorSwitch.isEnabled = !isLoading
        }
        
        viewModel.errorSaveDevice.bind { error in
            if let error = error {
                let alertController = UIAlertController(
                    title: String(localized: "error-title"),
                    message: error.localizedDescription,
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
        
        viewModel.successDeleteDevice.bind { [unowned self] isSuccess in
            if isSuccess {
                navigationController?.popToRootViewController(animated: true)
            }
        }
        
        viewModel.successSaveDevice.bind { isSuccess in
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
    }
    
    private func setupToolbar() {
        title = String(localized: "device-setting")
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
    
    private func setupUI() {
        sensorLabel.text = String(localized: "device-sensor")
        sensorSwitch.isOn = device.status == "ON"
        deviceNameLabel.text = String(localized: "device-name")
        deviceNameTextField.text = device.name
        
        saveButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "save"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
        
        deleteButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "delete-device"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .errorAccent
            ),
            for: .normal
        )
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onSaveButtonClicked(_ sender: Any) {
        viewModel.saveDevice(
            device: device,
            name: deviceNameTextField.text ?? "",
            status: sensorSwitch.isOn ? "ON" : "OFF"
        )
    }
    
    @IBAction func onDeleteButtonClicked(_ sender: Any) {
        viewModel.deleteDevice(deviceId: device.id)
    }
}

extension EditDeviceViewController  {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
