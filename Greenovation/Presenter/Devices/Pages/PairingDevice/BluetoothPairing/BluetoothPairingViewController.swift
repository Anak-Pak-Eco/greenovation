//
//  BluetoothPairingViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import UIKit

class BluetoothPairingViewController: UIViewController {

    @IBOutlet weak var chooseBluetoothTitleLabel: UILabel!
    @IBOutlet weak var bluetoothListTableView: UITableView!
//    @IBOutlet weak var searchTextField: UITextField!
    
    private let viewModel = BluetoothPairingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updatePeripheral.bind { [unowned self] load in
            if load {
                bluetoothListTableView.reloadData()
            }
        }
        viewModel.setConnectedPeripheral.bind { [unowned self] peripheral in
            if peripheral != nil {
                let vc = InputWifiViewController()
                vc.peripheral = peripheral
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        setupUI()
        setupToolbar()
        viewModel.checkBluetoothStatus()
    }
    
    private func setupToolbar() {
        title = "Bluetooth"
        navigationController?.navigationBar.prefersLargeTitles = false
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
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.stopScanning()
    }
    
    @objc private func onBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        chooseBluetoothTitleLabel.text = String(localized: "choose-bluetooth-title")
        
        // MARK: TableViewx
        bluetoothListTableView.register(
            UINib(nibName: "PeripheralItemCell", bundle: nil),
            forCellReuseIdentifier: "PeripheralItemCell"
        )
        bluetoothListTableView.separatorStyle = .none
        bluetoothListTableView.dataSource = self
        bluetoothListTableView.delegate = self
        
        // MARK: Search Bar Field
//        searchTextField.placeholder = String(localized: "find-bluetooth")
//        searchTextField.layer.borderWidth = 0.3
//        searchTextField.layer.cornerRadius = 10
//        searchTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
//        searchTextField.delegate = self
//        
//        let paddingView = UIView(
//            frame: CGRect(
//                x: 0,
//                y: 0,
//                width: 10,
//                height: searchTextField.frame.size.height
//            )
//        )
//        searchTextField.leftView = paddingView
//        searchTextField.leftViewMode = .always
//        
//        let imageWidth = 24
//        searchTextField.rightViewMode = .always
//        let buttonImage = UIButton(frame: CGRect(
//            x: 2,
//            y: 0,
//            width: 24,
//            height: searchTextField.frame.height)
//        )
//        let image = UIImage(systemName: "magnifyingglass")
//        buttonImage.setImage(image, for: .normal)
//        buttonImage.contentMode = .scaleAspectFit
//        buttonImage.tintColor = UIColor.secondaryAccent
//        buttonImage.addTarget(
//            self,
//            action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside
//        )
//        let containerView = UIView(
//            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(searchTextField.frame.height))
//        )
//        containerView.addSubview(buttonImage)
//        searchTextField.rightView = containerView
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        // TODO: SEARCH BLUETOOTH
    }
}

extension BluetoothPairingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TODO: SEARCH BLUETOOTH
        return true
    }
}

extension BluetoothPairingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.peripherals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bluetoothListTableView.dequeueReusableCell(withIdentifier: "PeripheralItemCell", for: indexPath) as! PeripheralItemCell
        
        let peripheral = viewModel.peripherals[indexPath.row]
        cell.setup(
            name: peripheral.name ?? "",
            isLast: indexPath.row == viewModel.peripherals.count - 1,
            isFirst: indexPath.row == 0
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let peripheral = viewModel.peripherals[indexPath.row]
        viewModel.connectToDevice(peripheral: peripheral)
    }
}
