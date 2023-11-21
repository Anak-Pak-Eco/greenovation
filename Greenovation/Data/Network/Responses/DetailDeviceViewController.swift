//
//  DetailDeviceViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class DetailDeviceViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    private let deviceId: String
    private let viewModel = DetailDeviceViewModel()
    
    init(deviceId: String) {
        self.deviceId = deviceId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.deviceId = ""
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
        viewModel.deviceHistoryFetchSuccess.bind { [unowned self] isSuccess in
            if isSuccess {
                mainTableView.reloadData()
            }
        }
        viewModel.observeDevice(deviceId: deviceId)
        viewModel.getHistories(deviceId: deviceId)
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
        title = ""
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
                target: self,
                action: #selector(onDeviceSettingClicked(_:))
            ),
            animated: true
        )
    }
    
    @objc func onDeviceSettingClicked(_ sender: UIBarButtonItem) {
        if let device = viewModel.device.value {
            let vc = EditDeviceViewController(device: device)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func onBackButtonClicked(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

extension DetailDeviceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.device.value != nil {
            if !viewModel.alerts.isEmpty {
                return 3
            } else {
                return 2
            }
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mainTableView.numberOfRows(inSection: 0) == 3 {
            if indexPath.row == 0 {
                let cell = mainTableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                
                cell.didSelectEditButton = { [unowned self] in
                    if let device = viewModel.device.value {
                        let vc = EditDevicePlantViewController(device: device)
                        navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                if let model = viewModel.device.value {
                    cell.setupData(device: model)
                }
                cell.selectionStyle = .none
                
                return cell
            } else if indexPath.row == 1 {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "DetailDeviceAlertTableViewCell",
                    for: indexPath
                ) as! DetailDeviceAlertTableViewCell
                
                cell.setupData(alerts: viewModel.alerts)
                cell.didSelectDoneButton = { [unowned self] type in
                    viewModel.onDeleteAlert(type: type)
                }
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "HistoryGraphTableViewCell",
                    for: indexPath
                ) as! HistoryGraphTableViewCell
                
                cell.setupData(histories: viewModel.deviceHistories)
                cell.selectionStyle = .none
                
                return cell
            }
        } else {
            if indexPath.row == 0 {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "HeaderTableViewCell",
                    for: indexPath
                ) as! HeaderTableViewCell
                
                if let model = viewModel.device.value {
                    cell.setupData(device: model)
                }
                cell.selectionStyle = .none
                
                return cell
            } else {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "HistoryGraphTableViewCell",
                    for: indexPath
                ) as! HistoryGraphTableViewCell
                
                cell.selectionStyle = .none
                cell.setupData(histories: viewModel.deviceHistories)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
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
