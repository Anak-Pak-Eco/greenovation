//
//  DeleteDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 01/11/23.
//

import UIKit

class DeleteDeviceViewController: UIViewController {
    
    @IBOutlet var UIDialogView: UIView!
    @IBOutlet var CancelButton: LocalizableButton!
    @IBOutlet var DeleteButton: LocalizableButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style()
        
        DeleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        CancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    func Style() {
        DeleteButton.layer.cornerRadius = 10.0
        
        UIDialogView.layer.cornerRadius = 10
        
        CancelButton.layer.cornerRadius = 10.0
        CancelButton.layer.borderWidth = 1.0
        CancelButton.layer.borderColor = UIColor.primaryAccent.cgColor
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    }
    
    @objc func deleteButtonTapped() {
//        print("Delete Button Tapped")
        SuccessDeleteDeviceViewController.showPopup(parentVC: self)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func cancelButtonTapped() {
//        print("Cancel Button Tapped")
        self.dismiss(animated: true, completion: nil)
    }
    
    static func showPopup(parentVC: UIViewController) {
        let popupViewController = DeleteDeviceViewController(nibName: "DeleteDeviceViewController", bundle: nil)
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        parentVC.present(popupViewController, animated: true, completion: nil)
    }

}
