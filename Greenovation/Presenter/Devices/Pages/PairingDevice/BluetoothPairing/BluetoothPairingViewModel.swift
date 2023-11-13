//
//  BluetoothPairingViewModel.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 12/11/23.
//

import Foundation
import CoreBluetooth

final class BluetoothPairingViewModel: NSObject {
    var centralManager: CBCentralManager?
    var peripherals: [CBPeripheral] = []
    let updatePeripheral = Box(false)
    let setConnectedPeripheral: Box<CBPeripheral?> = Box(nil)
    
    func checkBluetoothStatus() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    private func startScanning() {
        print("Start Scanning")
        centralManager?.scanForPeripherals(
            withServices: nil,
            options: [CBCentralManagerScanOptionAllowDuplicatesKey: false]
        )
    }
    
    func stopScanning() {
        print("Stop Scan")
        centralManager?.stopScan()
    }
    
    func connectToDevice(peripheral: CBPeripheral) {
        centralManager?.connect(peripheral)
    }
}

extension BluetoothPairingViewModel: CBCentralManagerDelegate, CBPeripheralDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Unkown")
            break
        case .resetting:
            print("Resetting")
            break
        case .unsupported:
            print("Unsupported")
            break
        case .unauthorized:
            print("Unauthorized")
            break
        case .poweredOff:
            print("Turned off")
            break
        case .poweredOn:
            print("Turned on")
            startScanning()
            break
        @unknown default:
            print("Unknown")
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: \(String(describing: peripheral.name)) \n \(peripheral.ancsAuthorized)")
        setConnectedPeripheral.value = peripheral
    }
    
    func centralManager(
        _ central: CBCentralManager,
        didDiscover peripheral: CBPeripheral,
        advertisementData: [String : Any],
        rssi RSSI: NSNumber
    ) {
        if let name = peripheral.name {
            if !peripherals.contains(peripheral) {
                print("didDiscover: \(String(describing: name))")
                peripherals.append(peripheral)
                updatePeripheral.value = true
            }
        }
    }
}
