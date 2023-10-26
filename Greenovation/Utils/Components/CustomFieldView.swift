//
//  CustomFieldView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit

final class CustomFieldView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    var items: [String] = ["Item 1", "Item 2", "Item 3"]
    
    var filteredItems: [String] = []
    
    var searchBarTableViewIsShow: Bool = false
    
    func makeFieldLabel(text: String) -> UILabel {
        let component = UILabel()
        component.text = text
        component.font = UIFont.boldSystemFont(ofSize: 16)
        component.textColor = .primaryAccent
        component.adjustsFontSizeToFitWidth = true
        component.textAlignment = .left
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    func makeTextField(text: String) -> UITextField {
        let component = UITextField()
        component.placeholder = text
        component.font = UIFont.boldSystemFont(ofSize: 16)
        component.returnKeyType = UIReturnKeyType.done
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = .white
        component.layer.cornerRadius = 10.0
        component.layer.borderColor = UIColor.secondaryAccent.cgColor
        component.layer.borderWidth = 2.0
        component.adjustsFontSizeToFitWidth = true
        component.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: component.frame.size.height))
        component.leftView = paddingView
        component.leftViewMode = .always
        
        return component
    }
    
    func makeFieldImage(image: UIImage) -> UIImageView {
        let component = UIImageView()
        component.image = image
        component.tintColor = .secondaryAccent
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    let searchBarTableView: UITableView = {
        let component = UITableView()
        component.backgroundColor = .red
        component.separatorStyle = .none
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        
        searchBarTableView.dataSource = self
        searchBarTableView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    func buildLayout() {
        
        let deviceNameLabel = makeFieldLabel(text: String(localized: "nama-perangkat"))
        let plantSearchLabel = makeFieldLabel(text: String(localized: "cari-tanaman"))
        let growthStepLabel = makeFieldLabel(text: String(localized: "tahap-pertumbuhan"))
        let deviceNameTextField = makeTextField(text: String(localized: ""))
        let plantSearchTextField = makeTextField(text: String(localized: "jenis-tanaman"))
        let growthStepTextField = makeTextField(text: String(localized: "fase-anakan"))
        let plantSearchImage = makeFieldImage(image: UIImage(systemName: "magnifyingglass")!)
        let growthStepImage = makeFieldImage(image: UIImage(systemName: "chevron.down")!)
        
        growthStepTextField.tintColor = .clear
        
        self.addSubview(deviceNameLabel)
        self.addSubview(deviceNameTextField)
        self.addSubview(plantSearchLabel)
        self.addSubview(plantSearchTextField)
        self.addSubview(plantSearchImage)
        self.addSubview(growthStepLabel)
        self.addSubview(growthStepTextField)
        self.addSubview(growthStepImage)
        
        plantSearchTextField.addTarget(self, action: #selector(plantSearchTextFieldDidChange(_:)), for: .editingChanged)
        growthStepTextField.addTarget(self, action: #selector(growthStepTextFieldDidTap(_:)), for: .editingDidBegin)
        
        NSLayoutConstraint.activate([
            deviceNameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 15),
            deviceNameLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deviceNameLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            deviceNameLabel.widthAnchor.constraint(equalToConstant: 358),
            deviceNameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            deviceNameTextField.topAnchor.constraint(equalTo: deviceNameLabel.bottomAnchor, constant: 5),
            deviceNameTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deviceNameTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            deviceNameTextField.widthAnchor.constraint(equalToConstant: 358),
            deviceNameTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            plantSearchLabel.topAnchor.constraint(equalTo: deviceNameTextField.bottomAnchor, constant: 15),
            plantSearchLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            plantSearchLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            plantSearchLabel.widthAnchor.constraint(equalToConstant: 358),
            plantSearchLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            plantSearchTextField.topAnchor.constraint(equalTo: plantSearchLabel.bottomAnchor, constant: 5),
            plantSearchTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            plantSearchTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            plantSearchTextField.widthAnchor.constraint(equalToConstant: 319),
            plantSearchTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            plantSearchImage.topAnchor.constraint(equalTo: plantSearchTextField.topAnchor, constant: 12),
            plantSearchImage.rightAnchor.constraint(equalTo: plantSearchTextField.rightAnchor, constant: -12),
            plantSearchImage.widthAnchor.constraint(equalToConstant: 19),
            plantSearchImage.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            growthStepLabel.topAnchor.constraint(equalTo: plantSearchTextField.bottomAnchor, constant: 15),
            growthStepLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            growthStepLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            growthStepLabel.widthAnchor.constraint(equalToConstant: 358),
            growthStepLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            growthStepTextField.topAnchor.constraint(equalTo: growthStepLabel.bottomAnchor, constant: 5),
            growthStepTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            growthStepTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
            growthStepTextField.widthAnchor.constraint(equalToConstant: 319),
            growthStepTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            growthStepImage.topAnchor.constraint(equalTo: growthStepTextField.topAnchor, constant: 12),
            growthStepImage.rightAnchor.constraint(equalTo: growthStepTextField.rightAnchor, constant: -12),
            growthStepImage.widthAnchor.constraint(equalToConstant: 19),
            growthStepImage.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier", for: indexPath)
        cell.textLabel?.text = filteredItems[indexPath.row]
        return cell
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredItems = items
        } else {
            filteredItems = items.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        searchBarTableView.reloadData() // Refresh the table view with filtered data
    }
    
    @objc func plantSearchTextFieldDidChange(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        filterItems(with: searchText)
        
        if let text = textField.text {
            print("Text changed: \(text)")
            searchBarTableViewIsShow = true
        }
        
        if searchBarTableViewIsShow == true {
            self.addSubview(searchBarTableView)
            
            NSLayoutConstraint.activate([
                searchBarTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 172),
                searchBarTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
                searchBarTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
//                searchBarTableView.topAnchor.constraint(equalTo: plantSearchTextField.bottomAnchor),
//                searchBarTableView.leftAnchor.constraint(equalTo: plantSearchTextField.leftAnchor),
//                searchBarTableView.rightAnchor.constraint(equalTo: plantSearchTextField.rightAnchor),
                searchBarTableView.widthAnchor.constraint(equalToConstant: 358),
                searchBarTableView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
    }
    
    @objc func growthStepTextFieldDidTap(_ textField: UITextField) {
        print("Growth Step Text Field Tapped")
        // Show bottom sheet
    }
    
}
