//
//  AddNewFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class AddNewFormulaViewController: UIViewController {
    
    @IBOutlet var SearchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = String(localized: "formula-tanaman")
        
        setupToolbar()
        setupUI()
    }
    
    private func setupToolbar() {
        self.title = String(localized: "tambah-formula")
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    private func setupUI() {
        SearchField.placeholder = NSLocalizedString(String(localized: "cari-tanaman"), comment: "TextField placeholder")
        SearchField.layer.borderWidth = 0.3
        SearchField.layer.borderColor = UIColor.secondaryAccent.cgColor
        SearchField.layer.cornerRadius = 10.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: SearchField.frame.size.height))
        SearchField.leftView = paddingView
        SearchField.leftViewMode = .always
        SearchField.addTarget(self, action: #selector(searchFieldDidChange), for: .editingChanged)
    }
    
    @objc func backButtonTapped() {
        
    }
    
    @objc func searchFieldDidChange() {
        
    }
    
}
