//
//  ViewController+Extension.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 15/10/23.
//

import UIKit
import SwiftUI

extension UIViewController {
    @discardableResult
    func addSwiftUIView<Content>(_ swiftUiView: Content, to view: UIView) -> UIHostingController<Content> where Content: View {
        let hostingController = UIHostingController(rootView: swiftUiView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
        return hostingController
    }
}
