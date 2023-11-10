//
//  SceneDelegate.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 29/09/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let user = Auth.auth().currentUser
        
//        if user != nil {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let navigationController = UINavigationController(rootViewController: EditDeviceV2ViewController())
            window = UIWindow(windowScene: windowScene)
            window?.overrideUserInterfaceStyle = .light
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
//        } else {
//            guard let windowScene = (scene as? UIWindowScene) else { return }
//            let navigationController = UINavigationController(rootViewController: OnboardingViewController())
//            window = UIWindow(windowScene: windowScene)
//            window?.overrideUserInterfaceStyle = .light
//            window?.rootViewController = navigationController
//            window?.makeKeyAndVisible()
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
            
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

