//
//  GrowthStepBottomSheetViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 14/11/23.
//

import UIKit

final class GrowthStepBottomSheetViewController: UIViewController {
    
    @IBOutlet weak var menengahImageView: UIImageView!
    @IBOutlet weak var awalImageView: UIImageView!
    @IBOutlet weak var anakanImageView: UIImageView!
    @IBOutlet weak var menengahPhaseStackView: UIStackView!
    @IBOutlet weak var awalPhaseStackView: UIStackView!
    @IBOutlet weak var separatorTwo: UIView!
    @IBOutlet weak var separatorOne: UIView!
    @IBOutlet weak var anakanPhaseStackView: UIStackView!
    
    private let plant: PlantModel
    private var chosenPhase: PlantModel.PlantPhaseModel?
    var delegate: AddDeviceGrowthStepDelegate?
    
    init(plant: PlantModel, chosenPhase: PlantModel.PlantPhaseModel?) {
        self.plant = plant
        self.chosenPhase = chosenPhase
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(plant: PlantModel(id: "", image_url: "", users_id: "", phases: [], name: ""), chosenPhase: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        separatorOne.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        separatorTwo.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        if let selectedPhase = chosenPhase {
            switch selectedPhase.step {
            case .anakan:
                anakanImageView.image = UIImage(named: "image-radio-selected")
            case .vegetatif_awal:
                awalImageView.image = UIImage(named: "image-radio-selected")
            case .vegetatif_menengah:
                menengahImageView.image = UIImage(named: "image-radio-selected")
            }
        }
        
        if let anakanPhase = plant.phases.first(where: { $0.step == .anakan }) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhaseAnakan(_:)))
            anakanPhaseStackView.isUserInteractionEnabled = true
            anakanPhaseStackView.addGestureRecognizer(tapGesture)
        }
        
        if let awalPhase = plant.phases.first(where: { $0.step == .vegetatif_awal }) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhaseAwal(_:)))
            awalPhaseStackView.isUserInteractionEnabled = true
            awalPhaseStackView.addGestureRecognizer(tapGesture)
        }
        
        if let menengahPhase = plant.phases.first(where: { $0.step == .vegetatif_menengah }) {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectPhaseMenengah(_:)))
            menengahPhaseStackView.isUserInteractionEnabled = true
            menengahPhaseStackView.addGestureRecognizer(tapGesture)
        }
    }
    
    @objc private func selectPhaseAnakan(_ sender: UIStackView) {
        if let anakanPhase = plant.phases.first(where: { $0.step == .anakan }) {
            delegate?.onPhaseSelected(anakanPhase)
            dismiss(animated: true)
        }
    }
    
    @objc private func selectPhaseAwal(_ sender: UIStackView) {
        if let awalPhase = plant.phases.first(where: { $0.step == .vegetatif_awal }) {
            delegate?.onPhaseSelected(awalPhase)
            dismiss(animated: true)
        }
    }
    
    @objc private func selectPhaseMenengah(_ sender: UIStackView) {
        if let menengahPhase = plant.phases.first(where: { $0.step == .vegetatif_menengah }) {
            delegate?.onPhaseSelected(menengahPhase)
            dismiss(animated: true)
        }
    }
    
    @IBAction func onDismissButtonClicked(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
