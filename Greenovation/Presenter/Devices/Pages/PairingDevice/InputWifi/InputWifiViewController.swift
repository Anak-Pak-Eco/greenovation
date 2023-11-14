//
//  InputWifiViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 13/11/23.
//

import UIKit
import CoreBluetooth

class InputWifiViewController: UIViewController, CBPeripheralDelegate {
    
    @IBOutlet weak var ssidTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var peripheral: CBPeripheral?
    var characteristic: CBCharacteristic?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        if let peripheral = peripheral {
            peripheral.delegate = self
            peripheral.discoverServices(nil)
        }
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        
        view.addGestureRecognizer(tap)
    }
    
    private func setupToolbar() {
        title = "Wifi"
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
    
    @objc private func onBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func onSubmitButtonClicked(_ sender: UIButton) {
        if ssidTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true {
            let alertController = UIAlertController(
                title: "Gagal Menyambungkan",
                message: "SSID atau Password belum terisi",
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
            if let data = "\(ssidTextField.text ?? ""),\(passwordTextField.text ?? "")".data(using: .utf8) {
                if let characteristic = characteristic {
                    peripheral?.writeValue(data, for: characteristic, type: .withResponse)
                    if let peripheral = peripheral {
                        peripheral.readValue(for: characteristic)
                        peripheral.setNotifyValue(true, for: characteristic)
                    }
                }
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        print("Discover characteristic: \(String(describing: service.characteristics))")
        characteristic = service.characteristics?[0]
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        print("Services: \(String(describing: peripheral.services))")
        if let service = peripheral.services?[0] {
            print("Service \(String(describing: service))")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            let data = String(decoding: value, as: UTF8.self)
            if data == "true" {
                let vc = AddDeviceV2ViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else if data == "false" {
                let alertController = UIAlertController(
                    title: "Gagal Menyambungkan",
                    message: "SSID atau Password salah",
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
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            print("updatedValue: \(String(decoding: value, as: UTF8.self))")
            let data = String(decoding: value, as: UTF8.self)
            if data == "true" {
                let vc = AddDeviceV2ViewController()
                navigationController?.pushViewController(vc, animated: true)
            } else if data == "false" {
                let alertController = UIAlertController(
                    title: "Gagal Menyambungkan",
                    message: "SSID atau Password salah",
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
    
    func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
        print("Invalidate: \(String(describing: invalidatedServices))")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateNotificationStateFor: \(peripheral)")
//        if let value = characteristic.value {
//            print("didUpdateNotificationState: \(String(decoding: value, as: UTF8.self))")
//        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor descriptor: CBDescriptor, error: Error?) {
        if let value = descriptor.value {
            print("Update Value For: \(String(describing: value))")
        }
    }
}
