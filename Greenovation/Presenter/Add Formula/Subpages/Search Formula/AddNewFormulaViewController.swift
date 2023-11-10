//
//  AddNewFormulaViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 07/11/23.
//

import UIKit

class AddNewFormulaViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
    }
    
    private func setupToolbar() {
        title = String(localized: "tambah-formula")
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "DMSans-SemiBold", size: 17)!,
            .foregroundColor: UIColor.onPrimaryFixed
        ]
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonClicked(_:))
        )
        
        navigationItem.setLeftBarButton(backButton, animated: true)
    }
    
    @objc func onBackButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        searchTextField.placeholder = String(localized: "cari-tanaman")
        searchTextField.layer.borderWidth = 0.3
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.borderColor = UIColor.secondaryAccent.cgColor
        searchTextField.delegate = self
        
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: searchTextField.frame.size.height
            )
        )
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        
        let imageWidth = 24
        searchTextField.rightViewMode = .always
        let buttonImage = UIButton(frame: CGRect(
            x: 2,
            y: 0,
            width: 24,
            height: searchTextField.frame.height)
        )
        let image = UIImage(systemName: "magnifyingglass")
        buttonImage.setImage(image, for: .normal)
        buttonImage.contentMode = .scaleAspectFit
        buttonImage.tintColor = UIColor.secondaryAccent
        buttonImage.addTarget(self, action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside)
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(searchTextField.frame.height))
        )
        containerView.addSubview(buttonImage)
        searchTextField.rightView = containerView
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        // viewModel.searchData(query: searchField.text ?? "")
        searchTextField.endEditing(true)
    }
}

extension AddNewFormulaViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension AddNewFormulaViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
