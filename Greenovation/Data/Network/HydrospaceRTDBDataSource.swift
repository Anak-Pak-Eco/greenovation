//
//  HydrospaceRTDBDataSource.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 07/10/23.
//

import Foundation
import FirebaseDatabase
import Combine

class HydrospaceRTDBDataSource {
    
    static let shared = HydrospaceRTDBDataSource()
    private let db = Database.database().reference()
    
    func getDevicesStatus() -> AnyPublisher<[DeviceResponse], Never> {
        let subject = CurrentValueSubject<[DeviceResponse], Never>([])
        
        let handle = db.child(DeviceResponse.reference).observe(.value) { snapshot in
            let value = snapshot.value as? NSDictionary
            if let value = value {
                let responses = value.allKeys.map { key in
                    DeviceResponse.from(response: value.object(forKey: key) as! NSDictionary)
                }
                subject.send(responses)
            }
        }
        
        return subject.handleEvents(receiveCancel: { [weak self] in
            self?.db.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
    
    func getDeviceStatus(id: String) -> AnyPublisher<DeviceResponse?, Never> {
        let subject = CurrentValueSubject<DeviceResponse?, Never>(nil)
        
        let handle = db.child(DeviceResponse.reference).child(id).observe(.value) { snapshot in
            let value = snapshot.value as? NSDictionary
            if let value = value {
                let response = DeviceResponse.from(response: value)
                subject.send(response)
            }
        }
        
        return subject.handleEvents(receiveCancel: { [weak self] in
            self?.db.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
}
