//
//  CustomLabel.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 24/10/23.
//

import UIKit

final class CustomLabel: UIView {
    
    let titleLabel: UILabel = {
        let component = UILabel()
        component.text = "Custom"
        component.font = UIFont.boldSystemFont(ofSize: 36)
        component.adjustsFontSizeToFitWidth = true
        component.textAlignment = .center
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    func buildLayout() {
        self.addSubview(titleLabel)
        
        titleLabel.backgroundColor = .yellow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 40)
        ])
    }
    
    func configureComponentData(text: String){
           titleLabel.text = text
    }
    
}
