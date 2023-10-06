//
//  FeaturesA.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import Foundation
import UIKit

class AuthorListViewController: UIViewController {
    
    @IBOutlet weak var authorSearchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var authorTableView: UITableView!
    
    lazy var viewModel: AuthorListViewModel = {
        return AuthorListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        observe()
        viewModel.initData()
    }
    
    private func initUI() {
        authorTableView.dataSource = self
        authorTableView.delegate = self
        authorSearchBar.delegate = self
        
        title = "Author List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func observe() {
        viewModel.authors.bind { [weak self] authors in
            self?.authorTableView.reloadData()
        }
        
        viewModel.authorsLoading.bind { [weak self] authorsLoading in
            if authorsLoading {
                self?.loading.startAnimating()
                self?.loading.isHidden = false
            } else {
                self?.loading.stopAnimating()
                self?.loading.isHidden = true
            }
        }
        
        viewModel.authorsError.bind { error in
            if let error = error {
                let alert = UIAlertController(title: "Failed to get authors", message: error, preferredStyle: .alert)
                self.present(alert, animated: true)
            }
        }
    }
}

extension AuthorListViewController {
    func navigateToTitleList(author: String) {
        let vc = TitleListViewController(author: author)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.title = author
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AuthorListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredAuthors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let author = viewModel.filteredAuthors[indexPath.row]
        cell.textLabel?.text = author.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let author = viewModel.filteredAuthors[indexPath.row]
        navigateToTitleList(author: author.name)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension AuthorListViewController: UISearchBarDelegate {
    
    private func searchData(query: String) {
        viewModel.searchAuthors(query: query)
        authorTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchData(query: searchBar.text ?? "")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchData(query: searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchData(query: searchBar.text ?? "")
    }
}
