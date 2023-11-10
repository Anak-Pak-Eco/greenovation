//
//  GrowthStepBottomSheetViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 08/11/23.
//

import UIKit

class GrowthStepBottomSheetViewController: UIViewController {
    
    @IBOutlet var dismisButton: UIImageView!
    @IBOutlet var faseAnakan: UIView!
    @IBOutlet var faseAwal: UIView!
    @IBOutlet var faseMenengah: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didtap()
    }
    
    @objc func dismisButtonTapped() {
        print("Dismiss Tapped")
    }
    
    @objc func faseAnakanButtonTapped() {
        print("Fase Anakan")
    }
    
    @objc func faseAwalButtonTapped() {
        print("Fase Awal")
    }
    
    @objc func faseMenengahButtonTapped() {
        print("Fase Menengah")
    }
    
    private func didtap() {
        // Dismiss Button Tapped
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisButtonTapped))
        dismisButton.isUserInteractionEnabled = true
        dismisButton.addGestureRecognizer(tapGesture)
        
        // Fase Anakan Button Tapped
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(faseAnakanButtonTapped))
        faseAnakan.isUserInteractionEnabled = true
        faseAnakan.addGestureRecognizer(tapGesture2)
        
        // Fase Awal Button Tapped
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(faseAwalButtonTapped))
        faseAwal.isUserInteractionEnabled = true
        faseAwal.addGestureRecognizer(tapGesture3)
        
        // Fase Menengah Button Tapped
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(faseMenengahButtonTapped))
        faseMenengah.isUserInteractionEnabled = true
        faseMenengah.addGestureRecognizer(tapGesture4)
    }
    
}
