//
//  CustomFieldViewModel.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 29/10/23.
//

import UIKit

class SharedData {
    static let shared = SharedData()
    var isBottomSheetVisible = Box(false)
    var isDone = Box(false)
    var bottomSheetSecondShow = false
}

//struct PlantModel {
//    var image: UIImage
//    var name: String
//}

final class CustomFieldViewModel {
    let modelArray: [PlantModel] = [
        PlantModel(id: "1", image_url: "image-seedling-big", users_id: "nisya", phases: [], name: ""),
//        PlantModel(image: UIImage(named: "image-awal")!, name: "Jeruk"),
//        PlantModel(image: UIImage(named: "image-seedling-big")!, name: "Duren"),
//        PlantModel(image: UIImage(named: "image-awal")!, name: "Jambu"),
//        PlantModel(image: UIImage(named: "image-seedling-big")!, name: "Timun")
    ]
}
