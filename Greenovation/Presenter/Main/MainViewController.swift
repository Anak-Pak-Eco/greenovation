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
        let viewController = NotificationViewController()
        return viewController
    }()
    
//    lazy var profileViewController: UIViewController = {
//        let viewController = ProfileViewController()
//        return viewController
//    }()
    
    lazy var formulaSettingViewController: UIViewController = {
        let viewController = FormulaSettingViewController()
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
        
//        profileViewController.tabBarItem = UITabBarItem(
//            title: String(localized: "profile"),
//            image: UIImage(systemName: "person.crop.circle.fill"),
//            tag: 3
//        )
        
        viewControllers = [
            deviceViewController,
            notificationViewController,
            formulaSettingViewController
        ]
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
