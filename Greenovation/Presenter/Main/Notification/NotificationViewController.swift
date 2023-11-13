//
//  NotificationViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var notifcationTableView: UITableView!
    @IBOutlet weak var emptyView: UIStackView!
    private let viewModel = NotificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initObserver()
        initUI()
    }
    
    private func initUI() {
        emptyView.isHidden = true
        notifcationTableView.register(
            UINib(nibName: "NotificationItemTableViewCell", bundle: nil),
            forCellReuseIdentifier: "NotificationItemTableViewCell"
        )
        notifcationTableView.register(
            UINib(nibName: "CustomLoadingCell", bundle: nil),
            forCellReuseIdentifier: "CustomLoadingCell"
        )
        notifcationTableView.refreshControl = UIRefreshControl()
        notifcationTableView.refreshControl?.addTarget(
            self,
            action: #selector(onRefreshTableView(_:)),
            for: .valueChanged
        )
        notifcationTableView.dataSource = self
        notifcationTableView.delegate = self
    }
    
    @objc private func onRefreshTableView(_ sender: UIRefreshControl) {
        if sender.isRefreshing {
            viewModel.getNotifications()
        }
        sender.endRefreshing()
    }
    
    private func initObserver() {
        viewModel.fetchNotificationLoading.bind { isLoading in
            self.notifcationTableView.reloadData()
        }
        
        viewModel.fetchNotificationSuccess.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                self.emptyView.isHidden = !viewModel.notifications.isEmpty
                self.notifcationTableView.isHidden = viewModel.notifications.isEmpty
                self.notifcationTableView.reloadData()
            }
        }
        
        viewModel.fetchNotificationFailed.bind { [weak self] message in
            guard let self = self else { return }
            if !message.isEmpty {
                let alertController = UIAlertController(
                    title: "Login Gagal",
                    message: message,
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
    
    override func viewWillAppear(_ animated: Bool) {
        setupToolbar()
        navigationController?.forceUpdateNavbar()
        viewModel.getNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.cancellable.forEach { cancellable in
            cancellable.cancel()
        }
    }
    
    private func setupToolbar() {
        tabBarController?.title = "Notifikasi"
        tabBarController?.navigationItem.setRightBarButtonItems(nil, animated: true)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.fetchNotificationLoading.value {
            return 1
        } else {
            return viewModel.notifications.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.fetchNotificationLoading.value {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLoadingCell", for: indexPath) as! CustomLoadingCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationItemTableViewCell", for: indexPath) as! NotificationItemTableViewCell
            
            cell.setupData(notification: viewModel.notifications[indexPath.row])
            
            return cell
        }
    }
}
