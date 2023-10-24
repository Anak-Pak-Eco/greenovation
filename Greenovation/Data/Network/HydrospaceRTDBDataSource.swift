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
    
    func getDeviceStatus(id: String) -> AnyPublisher<DeviceStatusResponse?, Never> {
        let subject = CurrentValueSubject<DeviceStatusResponse?, Never>(nil)
        
        let handle = db.child(DeviceStatusResponse.reference).child(id).observe(.value) { snapshot in
            let value = snapshot.value as? NSDictionary
            if let value = value {
                let currentPpm = value[DeviceStatusResponse.currentPpmReference] as? Double ?? 0.0
                let currentPh = value[DeviceStatusResponse.currentPhReference] as? Double ?? 0.0
                let name = value[DeviceStatusResponse.nameReference] as? String ?? ""
                let currentSteps = value[DeviceStatusResponse.currentStepsReference] as? String ?? ""
                let plantId = value[DeviceStatusResponse.plantIdReference] as? String ?? ""
                let userId = value[DeviceStatusResponse.userIdReference] as? String ?? ""
                
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
