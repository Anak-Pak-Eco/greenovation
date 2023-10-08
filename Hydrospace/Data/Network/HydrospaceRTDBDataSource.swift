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
    
    func    getDeviceStatus(id: String) -> AnyPublisher<DeviceStatusResponse?, Never> {
        let subject = CurrentValueSubject<DeviceStatusResponse?, Never>(nil)
        
        let handle = db.child("devices").child(id).observe(.value) { snapshot in
            let value = snapshot.value as? NSDictionary
            if let value = value {
                let currentPpm = value["current_tds"] as? Double ?? 0.0
                let currentPh = value["current_ph"] as? Double ?? 0.0
                let name = value["name"] as? String ?? ""
                let currentSteps = value["current_steps"] as? String ?? ""
                let plantId = value["plant_id"] as? String ?? ""
                let userId = value["user_id"] as? String ?? ""
                
                let response = DeviceStatusResponse(
                    currentPh: currentPh,
                    currentSteps: currentSteps,
                    currentPpm: currentPpm,
                    name: name,
                    plantId: plantId,
                    userId: userId
                )
                
                subject.send(response)
            }
        }
        
        return subject.handleEvents(receiveCancel: { [weak self] in
            self?.db.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
}
