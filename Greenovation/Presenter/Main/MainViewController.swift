//
//  MainViewController.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import UIKit
import SwiftUI

class MainViewController: UITabBarController {
    
    lazy var deviceViewController: UIViewController = {
        let viewController = DevicesViewController()
        return viewController
    }()
    
    lazy var notificationViewController: UIViewController = {
        let viewController = UINavigationController(
            rootViewController: UIHostingController(rootView: NotificationView())
        )
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    lazy var formulaSettingViewController: UIViewController = {
        let viewController = UINavigationController(
            rootViewController: UIHostingController(rootView: FormulaSettingView())
        )
        viewController.navigationBar.prefersLargeTitles = true
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceViewController.tabBarItem = UITabBarItem(
            title: String(localized: "devices"),
            image: UIImage(systemName: "platter.2.filled.iphone.landscape"),
            tag: 0
        )
        
        notificationViewController.tabBarItem = UITabBarItem(
            title: String(localized: "notification"),
            image: UIImage(systemName: "bell.fill"),
            tag: 1
        )
        
        formulaSettingViewController.tabBarItem = UITabBarItem(
            title: String(localized: "formula-setting"),
            image: UIImage(systemName: "leaf.fill"),
            tag: 2
        )
        
        viewControllers = [
            deviceViewController,
            notificationViewController,
            formulaSettingViewController
        ]
    }
}

extension MainViewController: NavigatorDelegate {
    func navigate(_ routes: Routes) {
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
