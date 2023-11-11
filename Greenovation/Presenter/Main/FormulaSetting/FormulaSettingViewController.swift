//
//  FormulaSettingViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 06/11/23.
//

import UIKit

class FormulaSettingViewController: UIViewController {
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var loadingProgressBar: UIActivityIndicatorView!
    @IBOutlet var formulaTableView: UITableView!
    @IBOutlet var searchField: UITextField!
    @IBOutlet weak var emptyView: UIView!
    
    private let viewModel = FormulaSettingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupToolbar()
        viewModel.getData()
    }
    
    private func setupObserver() {
        viewModel.successGetPlants.bind { [unowned self] isSuccess in
            if isSuccess {
                formulaTableView.reloadData()
                emptyView.isHidden = !viewModel.searchedPlants.isEmpty
            }
        }
        
        viewModel.loadingGetPlants.bind { [unowned self] isLoading in
            loadingProgressBar.isHidden = !isLoading
            formulaTableView.isHidden = isLoading
        }
        
        viewModel.errorGetPlants.bind { [unowned self] error in
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
    }
    
    private func setupUI() {
        // MARK: Empty View
        emptyView.isHidden = true
        
        // MARK: Separator
        separator.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        
        // MARK: Search Bar Field
        searchField.placeholder = String(localized: "cari-tanaman")
        searchField.layer.borderWidth = 0.3
        searchField.layer.cornerRadius = 10
        searchField.layer.borderColor = UIColor.secondaryAccent.cgColor
        searchField.delegate = self
        
        let paddingView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 10,
                height: searchField.frame.size.height
            )
        )
        searchField.leftView = paddingView
        searchField.leftViewMode = .always
        
        let imageWidth = 24
        searchField.rightViewMode = .always
        let buttonImage = UIButton(frame: CGRect(
            x: 2,
            y: 0,
            width: 24,
            height: searchField.frame.height)
        )
        let image = UIImage(systemName: "magnifyingglass")
        buttonImage.setImage(image, for: .normal)
        buttonImage.contentMode = .scaleAspectFit
        buttonImage.tintColor = UIColor.secondaryAccent
        buttonImage.addTarget(self, action: #selector(onSearchButtonClicked(_:)), for: .touchUpInside)
        let containerView = UIView(
            frame: CGRect(x: 0, y: 0, width: imageWidth + 14 , height: Int(searchField.frame.height))
        )
        containerView.addSubview(buttonImage)
        searchField.rightView = containerView
        
        formulaTableView.dataSource = self
        formulaTableView.delegate = self
        formulaTableView.separatorStyle = .none
        formulaTableView.register(
            UINib(nibName: "FormulaTableViewCell", bundle: nil),
            forCellReuseIdentifier: "FormulaTableViewCell"
        )
    }
    
    private func setupToolbar() {
        tabBarController?.title = String(localized: "plant-formula")  
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .plain,
                target: self,
                action: #selector(onAddButtonTapped(_:))
            ),
            animated: true
        )
    }
    
    @objc private func onSearchButtonClicked(_ sender: Any) {
        viewModel.searchData(query: searchField.text ?? "")
        searchField.endEditing(true)
    }
    
    @IBAction func onAddButtonTapped(_ sender: Any) {
        let vc = AddFormulaViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FormulaSettingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.searchData(query: textField.text ?? "")
        textField.resignFirstResponder()
        return true
    }
}

extension FormulaSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchedPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "FormulaTableViewCell",
            for: indexPath
        ) as! FormulaTableViewCell
        
        let plants = viewModel.searchedPlants
        let isLast = indexPath.row == (plants.count - 1)
        let plant = plants[indexPath.row]
        
        cell.setupData(plant, isLast: isLast)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let plant = viewModel.searchedPlants[indexPath.row]
        let vc = EditFormulaViewController(plant: plant)
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
