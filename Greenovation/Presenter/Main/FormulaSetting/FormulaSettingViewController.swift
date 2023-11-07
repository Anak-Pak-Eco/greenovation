//
//  FormulaSettingViewController.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 06/11/23.
//

import UIKit

class FormulaSettingViewController: UIViewController {
    
    @IBOutlet var formulaTableView: UITableView!
    @IBOutlet var SearchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
        formulaTableView.dataSource = self
        formulaTableView.delegate = self
        self.formulaTableView.register(UINib(nibName: "FormulaTableViewCell", bundle: nil), forCellReuseIdentifier: "FormulaTableViewCell")
    }
    
    private func setupUI() {
        SearchField.placeholder = NSLocalizedString(String(localized: "cari-tanaman"), comment: "TextField placeholder")
        SearchField.layer.borderWidth = 0.3
        SearchField.layer.borderColor = UIColor.secondaryAccent.cgColor
        SearchField.layer.cornerRadius = 10.0
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: SearchField.frame.size.height))
        SearchField.leftView = paddingView
        SearchField.leftViewMode = .always
        
//        formulaTableView.backgroundColor = .clear
    }
    
    private func setupToolbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        tabBarController?.title = String(localized: "formula-tanaman")
        tabBarController?.navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "plus"),
                style: .plain,
                target: self,
                action: #selector(addButtonTapped)
            ),
            animated: true
        )
    }
    
    @objc func addButtonTapped() {
        print("Add Button Tapped")
    }

}

extension FormulaSettingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormulaTableViewCell", for: indexPath) as! FormulaTableViewCell
        
        cell.formulaImage.image = UIImage(named: "Kangkung")
        cell.formulaLabel.text = "Kangkung \(indexPath.row + 1)"

        return cell
    }
    
}
