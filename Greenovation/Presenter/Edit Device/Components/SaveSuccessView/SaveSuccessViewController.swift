//
//  SaveSuccessViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 02/11/23.
//

import UIKit

class SaveSuccessViewController: UIViewController {
    
    @IBOutlet var UIDialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Style()
    }
    
    func Style() {
        UIDialogView.layer.cornerRadius = 10.0
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
    }
    
    static func showPopup(parentVC: UIViewController) {
        let popupViewController = SaveSuccessViewController(nibName: "SaveSuccessViewController", bundle: nil)
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        parentVC.present(popupViewController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            popupViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}
