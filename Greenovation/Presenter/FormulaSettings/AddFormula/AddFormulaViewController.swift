//
//  AddFormulaViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 10/11/23.
//

import UIKit

class AddFormulaViewController: UIViewController {

    @IBOutlet weak var plantsTableView: UITableView!
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    
    private let viewModel: AddFormulaViewModel = AddFormulaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadingGetPlants.bind { [unowned self] isLoading in
            loadingBar.isHidden = !isLoading
        }
        
        viewModel.successGetPlants.bind { [unowned self] success in
            if success {
                plantsTableView.reloadData()
            }
        }
        
        viewModel.errorGetPlants.bind { error in
            if !error.isEmpty {
                let alertController = UIAlertController(
                    title: "Login Gagal",
                    message: error,
                    preferredStyle: .alert
                )
                alertController.addAction(
                    .init(
                        title: "OK",
                        style: .destructive,
                        handler: { action in
                            alertController.dismiss(animated: true)
                        }
                    )
                )
                self.present(alertController, animated: true)
            }
        }
        
        setupToolbar()
        setupUI()
        viewModel.getData()
    }
    
    private func setupToolbar() {
        title = "Tambah Formula"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "DMSans-SemiBold", size: 17)!,
            .foregroundColor: UIColor.onPrimaryFixed
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(onBackButtonClicked(_:))
        )
    }
    
    @objc private func onBackButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupUI() {
        // MARK: Table View Setup
        plantsTableView.register(
            UINib(nibName: "EmptyPlantItemCell", bundle: nil),
            forCellReuseIdentifier: "EmptyPlantItemCell"
        )
        plantsTableView.register(
            UINib(nibName: "PlantSearchItemCell", bundle: nil),
            forCellReuseIdentifier: "PlantSearchItemCell"
        )
        plantsTableView.allowsSelection = false
        plantsTableView.separatorStyle = .none
        plantsTableView.isHidden = true
        plantsTableView.delegate = self
        plantsTableView.dataSource = self
        
        // MARK: Search Bar Field
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
        buttonImage.addTarget(
            self,
            action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside
        )
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(searchTextField.frame.height))
        )
        containerView.addSubview(buttonImage)
        searchTextField.rightView = containerView
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        viewModel.searchData(query: searchTextField.text ?? "")
        searchTextField.endEditing(true)
        plantsTableView.isHidden = false
    }
}

extension AddFormulaViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.searchData(query: textField.text ?? "")
        plantsTableView.isHidden = false
        textField.resignFirstResponder()
        return true
    }
}

extension AddFormulaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedPlants.count == 0 ? 1 : viewModel.searchedPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searchedPlants.isEmpty {
            let cell = plantsTableView.dequeueReusableCell(
                withIdentifier: "EmptyPlantItemCell",
                for: indexPath
            ) as! EmptyPlantItemCell
            
            cell.selectionStyle = .none
            
            cell.didClickAddButton = { [unowned self] in
                let viewController = RegisterFormulaViewController(
                    plant: PlantModel(
                        id: "",
                        image_url: "",
                        users_id: "",
                        phases: [],
                        name: searchTextField.text ?? ""
                    )
                )
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            return cell
        } else {
            let cell = plantsTableView.dequeueReusableCell(
                withIdentifier: "PlantSearchItemCell",
                for: indexPath
            ) as! PlantSearchItemCell
            
            cell.selectionStyle = .none
            
            let plant = viewModel.searchedPlants[indexPath.row]
            
            cell.setup(plant: plant)
            cell.didSelectPlant = { [unowned self] in
                let viewController = RegisterFormulaViewController(
                    plant: plant
                )
                navigationController?.pushViewController(viewController, animated: true)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
