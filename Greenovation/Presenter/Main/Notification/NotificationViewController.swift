//
//  NotificationViewController.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 30/10/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyDescriptionLabel: UILabel!
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var emptyView: UIStackView!
    private let viewModel = NotificationViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initObserver()
        initUI()
    }
    
    private func initUI() {
        emptyTitleLabel.text = String(localized: "notification-empty-title")
        emptyDescriptionLabel.text = String(localized: "notification-empty-description")
        emptyView.isHidden = true
        notificationTableView.register(
            UINib(nibName: "NotificationItemTableViewCell", bundle: nil),
            forCellReuseIdentifier: "NotificationItemTableViewCell"
        )
        notificationTableView.register(
            UINib(nibName: "CustomLoadingCell", bundle: nil),
            forCellReuseIdentifier: "CustomLoadingCell"
        )
        notificationTableView.refreshControl = UIRefreshControl()
        notificationTableView.refreshControl?.addTarget(
            self,
            action: #selector(onRefreshTableView(_:)),
            for: .valueChanged
        )
        notificationTableView.dataSource = self
        notificationTableView.delegate = self
    }
    
    @objc private func onRefreshTableView(_ sender: UIRefreshControl) {
        if sender.isRefreshing {
            viewModel.getNotifications()
        }
        sender.endRefreshing()
    }
    
    private func initObserver() {
        viewModel.fetchNotificationLoading.bind { isLoading in
            self.notificationTableView.reloadData()
        }
        
        viewModel.fetchNotificationSuccess.bind { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                self.emptyView.isHidden = !viewModel.notifications.isEmpty
                self.notificationTableView.isHidden = viewModel.notifications.isEmpty
                self.notificationTableView.reloadData()
            }
        }
        
        viewModel.fetchNotificationFailed.bind { [weak self] message in
            guard let self = self else { return }
            if !message.isEmpty {
                let alertController = UIAlertController(
                    title: "Gagal Mendapatkan Notifikasi",
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
        tabBarController?.title = String(localized: "notification")
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
