//
//  FeaturesBViewController.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import Foundation
import UIKit

class TitleListViewController: UIViewController {
    
    @IBOutlet weak var titleTableView: UITableView!
    @IBOutlet weak var titleLoading: UIActivityIndicatorView!
    
    private lazy var viewModel = {
        return TitleListViewModel()
    }()
    
    private var author: String = ""
    
    init(author: String) {
        super.init(nibName: nil, bundle: nil)
        self.author = author
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(author: "test")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        observe()
        viewModel.initData(author: author)
    }
    
    private func initUI() {
        self.titleTableView.dataSource = self
        self.titleTableView.delegate = self
    }
    
    private func observe() {
        viewModel.titles.bind { [weak self] titles in
            self?.titleTableView.reloadData()
        }
        
        viewModel.titlesLoading.bind { [weak self] isLoading in
            if isLoading {
                self?.titleLoading.startAnimating()
            } else {
                self?.titleLoading.stopAnimating()
                self?.titleLoading.hidesWhenStopped = true
                self?.titleLoading.isHidden = true
            }
        }
        
        viewModel.titlesError.bind { [weak self] error in
            if error != "" {
                let alert = UIAlertController(title: "Error getting titles", message: error, preferredStyle: .alert)
                self?.present(alert, animated: true)
            }
        }
    }
}

extension TitleListViewController {
    
    func navigateToPoetryDetail(author: String, title: String) {
        let vc = PoetryDetailViewController(author: author, title: title)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.title = title
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.backButtonTitle = "Back"
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TitleListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titles.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let title = viewModel.titles.value[indexPath.row]
        cell.textLabel?.text = title.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = viewModel.titles.value[indexPath.row].title
        navigateToPoetryDetail(author: author, title: title)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
