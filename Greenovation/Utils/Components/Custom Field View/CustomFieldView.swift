//
//  CustomFieldView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit
import SwiftUI

final class CustomFieldView: UIView {
    
    let bottomSheetView = CustomGrowthStepView()
    let bottomSheetHeight: CGFloat = 350
    
    let viewModel = CustomFieldViewModel()
    var filteredItems: [PlantModel] = []
    
    lazy var moodSelectionVC = UIStoryboard(name: "GrowthStepViewController", bundle: nil).instantiateViewController(withIdentifier: "GrowthStepViewController")
    
    var searchBarTableViewIsShow: Bool = false
    
    func makeLabel(text: String, color: UIColor) -> UILabel {
        let component = UILabel()
        component.text = text
        component.font = UIFont.systemFont(ofSize: 17)
        component.textColor = color
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
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
    
    func makeButtonField(text: String) -> UIButton {
        let component = UIButton()
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = .white
        component.layer.cornerRadius = 10.0
        component.layer.borderColor = UIColor.secondaryAccent.cgColor
        component.layer.borderWidth = 2.0
        component.setTitle(text, for: .normal)
        component.translatesAutoresizingMaskIntoConstraints = false
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
        component.separatorStyle = .none
        component.allowsSelection = true
        component.register(UINib(nibName: "CustomSearchItemCell", bundle: nil), forCellReuseIdentifier: "CustomSearchItemCell")
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    let plantSearchTextField: UITextField = {
        let component = UITextField()
        component.placeholder = String(localized: "fase-anakan")
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
    } ()
    
    let plantNotFountViiew: UIView = {
        let component = UIView()
        component.backgroundColor = .white
        component.layer.cornerRadius = 10.0
        component.layer.borderWidth = 1.0
        component.layer.borderColor = UIColor.secondaryAccent.cgColor
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    let notFoundLabel: UILabel = {
        let component = UILabel()
        component.text = String(localized: "tanaman-tidak-ditemukan")
        component.font = UIFont.systemFont(ofSize: 17)
        component.textColor = .label
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    let addButton: UIButton = {
        let component = UIButton()
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = UIColor.primaryAccent
        component.layer.cornerRadius = 10.0
        component.setTitle(String(localized: "tambah-pengaturan-baru"), for: .normal)
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    func buildLayout() {
        self.backgroundColor = .clear
        
        let deviceNameLabel = makeFieldLabel(text: String(localized: "nama-perangkat"))
        let plantSearchLabel = makeFieldLabel(text: String(localized: "cari-tanaman"))
        let growthStepLabel = makeFieldLabel(text: String(localized: "tahap-pertumbuhan"))
        let deviceNameTextField = makeTextField(text: String(localized: ""))
//        let plantSearchTextField = makeTextField(text: String(localized: "jenis-tanaman"))
//        let growthStepTextField = makeTextField(text: String(localized: "fase-anakan"))
        let growthStepPlaceholder = makeLabel(text: String(localized: "fase-anakan"), color: .surfaceContainerHigh)
        let growthStepTextField = makeButtonField(text: String(localized: "fase-anakan"))
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
        self.addSubview(growthStepPlaceholder)
        self.addSubview(growthStepImage)
        
        plantSearchTextField.addTarget(self, action: #selector(plantSearchTextFieldDidChange(_:)), for: .editingChanged)
        growthStepTextField.addTarget(self, action: #selector(growthStepTextFieldDidTap(_:)), for: .touchUpInside)
        
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
            growthStepPlaceholder.topAnchor.constraint(equalTo: growthStepTextField.topAnchor, constant: 11.5),
            growthStepPlaceholder.leftAnchor.constraint(equalTo: growthStepTextField.leftAnchor, constant: 10),
            growthStepPlaceholder.bottomAnchor.constraint(equalTo: growthStepTextField.bottomAnchor, constant: -11.5),
            growthStepPlaceholder.widthAnchor.constraint(equalToConstant: 319),
            growthStepPlaceholder.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            growthStepImage.topAnchor.constraint(equalTo: growthStepTextField.topAnchor, constant: 12),
            growthStepImage.rightAnchor.constraint(equalTo: growthStepTextField.rightAnchor, constant: -12),
            growthStepImage.widthAnchor.constraint(equalToConstant: 19),
            growthStepImage.heightAnchor.constraint(equalToConstant: 21)
        ])
        
    }
    
    func filterItems(with searchText: String) {
        if searchText.isEmpty {
            filteredItems = []
        } else {
            filteredItems = viewModel.modelArray.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        searchBarTableView.reloadData()
    }
    
    @objc func plantSearchTextFieldDidChange(_ textField: UITextField) {
        
        let searchText = textField.text ?? ""
        filterItems(with: searchText)
        
        if let text = textField.text {
            print("Text changed: \(text)")
            searchBarTableViewIsShow = true
        }
        
        if searchBarTableViewIsShow == true {
            if filteredItems.isEmpty {
                searchBarTableView.removeFromSuperview()
                
                self.addSubview(plantNotFountViiew)
                self.addSubview(notFoundLabel)
                self.addSubview(addButton)
                
                addButton.addTarget(self, action: #selector(addButtonDidTap(_:)), for: .touchUpInside)
                
                NSLayoutConstraint.activate([
                    plantNotFountViiew.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 182),
                    plantNotFountViiew.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
                    plantNotFountViiew.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
                    plantNotFountViiew.widthAnchor.constraint(equalToConstant: 358),
                    plantNotFountViiew.heightAnchor.constraint(equalToConstant: 116),
                    notFoundLabel.topAnchor.constraint(equalTo: plantNotFountViiew.topAnchor, constant: 20),
                    notFoundLabel.leftAnchor.constraint(equalTo: plantNotFountViiew.leftAnchor, constant: 10),
                    notFoundLabel.widthAnchor.constraint(equalToConstant: 195),
                    notFoundLabel.heightAnchor.constraint(equalToConstant: 21),
                    addButton.topAnchor.constraint(equalTo: notFoundLabel.bottomAnchor, constant: 15),
                    addButton.leftAnchor.constraint(equalTo: plantNotFountViiew.leftAnchor, constant: 15),
                    addButton.rightAnchor.constraint(equalTo: plantNotFountViiew.rightAnchor, constant: -15),
                    addButton.widthAnchor.constraint(equalToConstant: 328),
                    addButton.heightAnchor.constraint(equalToConstant: 40)
                ])
                
            } else {
                plantNotFountViiew.removeFromSuperview()
                notFoundLabel.removeFromSuperview()
                addButton.removeFromSuperview()
                
                self.addSubview(searchBarTableView)
                searchBarTableView.dataSource = self
                searchBarTableView.delegate = self
                searchBarTableView.backgroundColor = .clear
                
                NSLayoutConstraint.activate([
                    searchBarTableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 182),
                    searchBarTableView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
                    searchBarTableView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
                    searchBarTableView.widthAnchor.constraint(equalToConstant: 358),
                    searchBarTableView.heightAnchor.constraint(equalToConstant: 150)
                ])
            }
        }
        
    }
    
    @objc func addButtonDidTap(_ textField: UITextField) {
        print("Add Button Tapped")
        plantNotFountViiew.removeFromSuperview()
        notFoundLabel.removeFromSuperview()
        addButton.removeFromSuperview()
    }
    
    @objc func growthStepTextFieldDidTap(_ textField: UITextField) {
        print("Growth Step Text Field Tapped")
        
        // Show bottom sheet
        if SharedData.shared.isBottomSheetVisible.value {
            // Hide the bottom sheet with animation
            animateBottomSheet(toY: frame.height)
            SharedData.shared.isBottomSheetVisible.value = false
            // After the animation, remove it from the view
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.bottomSheetView.removeFromSuperview()
            }
        } else {
            // Show the bottom sheet
            addSubview(bottomSheetView)
            bottomSheetView.frame = CGRect(x: 0, y: frame.height, width: frame.width, height: bottomSheetHeight)
            animateBottomSheet(toY: frame.height - bottomSheetHeight)
            SharedData.shared.isBottomSheetVisible.value = true
        }
        
    }

    func animateBottomSheet(toY: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetView.frame.origin.y = toY
        }
    }
    
}

extension CustomFieldView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSearchItemCell", for: indexPath) as! CustomSearchItemCell
        
        if indexPath.row < filteredItems.count {
            let filteredItem = filteredItems[indexPath.row]
            cell.configure(with: filteredItem.image, and: filteredItem.name)
        }
        
        print("id: \(indexPath.row), filter: \(filteredItems) \(filteredItems.count)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = filteredItems[indexPath.row]
        
        plantSearchTextField.text = selectedItem.name
        searchBarTableView.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76.0
    }

    
}
