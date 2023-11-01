//
//  DetailDeviceViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class DetailDeviceViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    private let viewModel = DetailDeviceViewModel()
    var deviceId: String!
    
    init(deviceId: String) {
        super.init(nibName: nil, bundle: nil)
        self.deviceId = deviceId
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolbar()
        setupUI()
        viewModel.device.bind { [weak self] model in
            guard let self = self else { return }
            if model != nil {
                self.title = model?.name
                self.mainTableView.reloadData()
            }
        }
        viewModel.observeDevice(deviceId: deviceId)
    }
    
    private func setupUI() {
        mainTableView.register(
            UINib(nibName: "HeaderTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HeaderTableViewCell"
        )
        mainTableView.register(
            UINib(nibName: "DetailDeviceAlertTableViewCell", bundle: nil),
            forCellReuseIdentifier: "DetailDeviceAlertTableViewCell"
        )
        mainTableView.register(
            UINib(nibName: "HistoryGraphTableViewCell", bundle: nil),
            forCellReuseIdentifier: "HistoryGraphTableViewCell"
        )
        mainTableView.alwaysBounceVertical = false
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.separatorStyle = .none
        mainTableView.reloadData()
    }
    
    private func setupToolbar() {
        title = "Perangkat 3"
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
        navigationItem.setRightBarButton(
            UIBarButtonItem(
                image: UIImage(systemName: "gearshape.fill"),
                style: .plain,
                target: nil,
                action: nil
            ),
            animated: true
        )
    }
    
    @objc func onBackButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.device.value != nil {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.device.value != nil {
            return 3
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let uiView = UIView()
        return uiView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            if let model = viewModel.device.value {
                cell.setupData(device: model)
            }
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "DetailDeviceAlertTableViewCell", for: indexPath) as! DetailDeviceAlertTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "HistoryGraphTableViewCell", for: indexPath) as! HistoryGraphTableViewCell
            cell.selectionStyle = .none
            return cell
        }
    }
}

extension DetailDeviceViewController {
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
