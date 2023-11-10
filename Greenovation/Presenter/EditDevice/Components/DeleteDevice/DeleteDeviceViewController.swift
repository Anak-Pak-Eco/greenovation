//
//  DeleteDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 01/11/23.
//

import UIKit

class DeleteDeviceViewController: UIViewController {
    
    @IBOutlet var dialogView: UIView!
    @IBOutlet var cancelButton: LocalizableButton!
    @IBOutlet var deleteButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        dialogView.layer.cornerRadius = 10
        
        deleteButton.layer.cornerRadius = 10
        deleteButton.addTarget(
            self,
            action: #selector(deleteButtonTapped), for: .touchUpInside
        )
        
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.primaryAccent.cgColor
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped), for: .touchUpInside
        )
    }
    
    @objc private func deleteButtonTapped() {
        SuccessDeleteDeviceViewController.showPopup(parentVC: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    static func showPopup(parentVC: UIViewController) {
        let popupViewController = DeleteDeviceViewController(
            nibName: "DeleteDeviceViewController",
            bundle: nil
        )
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        parentVC.present(popupViewController, animated: true, completion: nil)
    }
}
