//
//  PoetryDetailViewController.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 01/10/23.
//

import Foundation
import UIKit

class PoetryDetailViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    private let viewModel = PoetryDetailViewModel()
    
    let author: String
    let poetryTitle: String
    
    init(author: String, title: String) {
        self.author = author
        self.poetryTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(author: "", title: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        observe()
        viewModel.initData(author: author, title: poetryTitle)
    }
    
    private func initUI() {
        mainTableView.register(
            UINib(nibName: "AuthorCell", bundle: nil), 
            forCellReuseIdentifier: "AuthorCell"
        )
        mainTableView.register(
            UINib(nibName: "PoetryLineTableViewCell", bundle: nil),
            forCellReuseIdentifier: "PoetryLineTableViewCell"
        )
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.estimatedRowHeight = 80.0
        mainTableView.selectionFollowsFocus = false
        mainTableView.allowsSelection = false
        mainTableView.reloadData()
    }
    
    private func observe() {
        viewModel.poetries.bind { poetries in
            if !poetries.isEmpty {
                if !poetries[0].lines.isEmpty {
                    self.mainTableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension PoetryDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if viewModel.poetries.value.isEmpty {
            1
        } else {
            viewModel.poetries.value[0].lines.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let authorCell = tableView.dequeueReusableCell(withIdentifier: "AuthorCell", for: indexPath) as! AuthorCell
            authorCell.setAuthorLabel(author: author)
            return authorCell
        } else {
            let poetryLineCell = tableView.dequeueReusableCell(withIdentifier: "PoetryLineTableViewCell", for: indexPath) as! PoetryLineTableViewCell
            poetryLineCell.setPoetryLine(viewModel.poetries.value[0].lines[indexPath.row - 1])
            return poetryLineCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
