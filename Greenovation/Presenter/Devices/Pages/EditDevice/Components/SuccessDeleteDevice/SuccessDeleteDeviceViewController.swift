//
//  SuccessDeleteDeviceViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 02/11/23.
//

import UIKit

class SuccessDeleteDeviceViewController: UIViewController {
    
    @IBOutlet var UIDialogView: UIView!
    @IBOutlet var SuccessLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        UIDialogView.layer.cornerRadius = 10
    }
    
    static func showPopup(parentVC: UIViewController) {
        let popupViewController = SuccessDeleteDeviceViewController(
            nibName: "SuccessDeleteDeviceViewController", 
            bundle: nil
        )
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        parentVC.present(popupViewController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            popupViewController.dismiss(animated: true, completion: nil)
        }
    }
}
