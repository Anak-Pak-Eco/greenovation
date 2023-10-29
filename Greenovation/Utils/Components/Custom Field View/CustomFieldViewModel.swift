//
//  CustomFieldViewModel.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 29/10/23.
//

import UIKit

class SharedData {
    static let shared = SharedData()
    var isBottomSheetVisible = false
    var isDone = false
    var bottomSheetSecondShow = false
}

struct PlantModel {
    var image: UIImage
    var name: String
}

final class CustomFieldViewModel {
    let modelArray: [PlantModel] = [
        PlantModel(image: UIImage(named: "image-anakan")!, name: "Kangkung"),
        PlantModel(image: UIImage(named: "image-awal")!, name: "Jeruk"),
        PlantModel(image: UIImage(named: "image-anakan")!, name: "Duren"),
        PlantModel(image: UIImage(named: "image-awal")!, name: "Jambu"),
        PlantModel(image: UIImage(named: "image-anakan")!, name: "Timun")
    ]
}
