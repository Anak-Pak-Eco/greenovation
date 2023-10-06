//
//  MainViewController.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import UIKit
import SwiftUI

class MainViewController: UITabBarController, NavigatorDelegate {
    
    lazy var deviceViewController: UINavigationController = {
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: DevicesView(navigator: self)))
        viewController.title = "Perangkat"
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    lazy var notificationViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: NotificationView()))
        viewController.title = "Notifikasi"
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    lazy var formulaSettingViewController: UIViewController = {
        let viewController = UINavigationController(rootViewController: UIHostingController(rootView: FormulaSettingView()))
        viewController.title = "Pengaturan Formula"
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceViewController.tabBarItem = UITabBarItem(
            title: "Perangkat",
            image: UIImage(systemName: "platter.2.filled.iphone.landscape"),
            tag: 0
        )
        
        notificationViewController.tabBarItem = UITabBarItem(
            title: "Notifikasi",
            image: UIImage(systemName: "bell.fill"),
            tag: 1
        )
        
        formulaSettingViewController.tabBarItem = UITabBarItem(
            title: "Pengaturan Formula",
            image: UIImage(systemName: "leaf.fill"),
            tag: 2
        )
        
        viewControllers = [deviceViewController, notificationViewController, formulaSettingViewController]
    }
    
    func navigateToDetailPage() {
        let detailVC = UIHostingController(rootView: DetailDeviceView())
        detailVC.navigationItem.setHidesBackButton(true, animated: true)
        deviceViewController.pushViewController(detailVC, animated: true)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
