//
//  CustomMyChoiceView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit

final class CustomMyChoiceView: UIView {
    
    func makeLabel(text: String, size: CGFloat) -> UILabel {
        let component = UILabel()
        component.text = text
        component.font = UIFont.systemFont(ofSize: size)
        component.textColor = UIColor.onPrimaryFixed
        component.adjustsFontSizeToFitWidth = true
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    func makeBackgroung(color: UIColor) -> UIView {
        let component = UIView()
        component.backgroundColor = color
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    func makeTextField(text: String) -> UITextField {
        let component = UITextField()
        component.placeholder = text
        component.font = UIFont.systemFont(ofSize: 17)
        component.returnKeyType = UIReturnKeyType.done
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = .white
        component.layer.cornerRadius = 6.0
        component.layer.borderColor = UIColor.primaryAccent.cgColor
        component.layer.borderWidth = 1.0
        component.adjustsFontSizeToFitWidth = true
        component.translatesAutoresizingMaskIntoConstraints = false
        component.keyboardType = .numberPad
        component.textAlignment = .center
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        component.attributedPlaceholder = attributedPlaceholder
        return component
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    func buildLayout() {
        let backgroundWhite = makeBackgroung(color: .white)
        let backgroundSecondary = makeBackgroung(color: .secondaryContainer)
        let titleLabel = makeLabel(text: String(localized: "**pilihan-saya**"), size: 15)
        let recommendationLabel = makeLabel(text: String(localized: "rekomendasi"), size: 13)
        let descLabel = makeLabel(text: String(localized: "Rekomendasi yang kami berikan didapatkan dari blabla untuk **\("Caisim")** pada **\("Fase Anakan")**"), size: 12)
        let ppmLabel = makeLabel(text: String(localized: "**Kepekatan Nutrisi** (ppm)"), size: 15)
        let ppmMinField = makeTextField(text: String(localized: "750"))
        let strip1 = makeLabel(text: "-", size: 17)
        let ppmMaxField = makeTextField(text: "1200")
        let phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
        let phMinField = makeTextField(text: "5.5")
        let strip2 = makeLabel(text: "-", size: 17)
        let phMaxField = makeTextField(text: "7.5")
        
        descLabel.numberOfLines = 2
        
        backgroundSecondary.layer.cornerRadius = 8.0
        
        backgroundWhite.layer.cornerRadius = 8.0
        backgroundWhite.layer.shadowColor = UIColor.black.cgColor
        backgroundWhite.layer.shadowOffset = CGSize(width: 0, height: 3)
        backgroundWhite.layer.shadowRadius = 12
        backgroundWhite.layer.shadowOpacity = 0.04
        backgroundWhite.layer.masksToBounds = false
        
        self.addSubview(backgroundWhite)
        self.addSubview(backgroundSecondary)
        self.addSubview(titleLabel)
        self.addSubview(recommendationLabel)
        self.addSubview(descLabel)
        self.addSubview(ppmLabel)
        self.addSubview(ppmMinField)
        self.addSubview(strip1)
        self.addSubview(ppmMaxField)
        self.addSubview(phLabel)
        self.addSubview(phMinField)
        self.addSubview(strip2)
        self.addSubview(phMaxField)
        
        NSLayoutConstraint.activate([
            backgroundWhite.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundWhite.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            backgroundWhite.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            backgroundWhite.widthAnchor.constraint(equalToConstant: 358),
            backgroundWhite.heightAnchor.constraint(equalToConstant: 213)
        ])
        
        NSLayoutConstraint.activate([
            backgroundSecondary.topAnchor.constraint(equalTo: backgroundWhite.topAnchor),
            backgroundSecondary.leftAnchor.constraint(equalTo: backgroundWhite.leftAnchor),
            backgroundSecondary.rightAnchor.constraint(equalTo: backgroundWhite.rightAnchor),
            backgroundSecondary.widthAnchor.constraint(equalToConstant: 358),
            backgroundSecondary.heightAnchor.constraint(equalToConstant: 40.81)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundSecondary.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: backgroundSecondary.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: backgroundSecondary.rightAnchor, constant: -242),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundSecondary.bottomAnchor, constant: -10.81),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            recommendationLabel.topAnchor.constraint(equalTo: backgroundSecondary.bottomAnchor, constant: 11.45),
            recommendationLabel.leftAnchor.constraint(equalTo: backgroundWhite.leftAnchor, constant: 16),
            recommendationLabel.rightAnchor.constraint(equalTo: backgroundWhite.rightAnchor, constant: -248),
            recommendationLabel.widthAnchor.constraint(equalToConstant: 78),
            recommendationLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: recommendationLabel.bottomAnchor, constant: 10),
            descLabel.leftAnchor.constraint(equalTo: backgroundWhite.leftAnchor, constant: 16),
            descLabel.rightAnchor.constraint(equalTo: backgroundWhite.rightAnchor, constant: -16),
            descLabel.widthAnchor.constraint(equalToConstant: 326),
            descLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            ppmLabel.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 17),
            ppmLabel.leftAnchor.constraint(equalTo: backgroundWhite.leftAnchor, constant: 16),
            ppmLabel.widthAnchor.constraint(equalToConstant: 169),
            ppmLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ppmMinField.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10),
            ppmMinField.leftAnchor.constraint(equalTo: ppmLabel.rightAnchor, constant: 14),
            ppmMinField.widthAnchor.constraint(equalToConstant: 65),
            ppmMinField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            strip1.topAnchor.constraint(equalTo: ppmMinField.topAnchor, constant: 6),
            strip1.leftAnchor.constraint(equalTo: ppmMinField.rightAnchor, constant: 2),
            strip1.widthAnchor.constraint(equalToConstant: 9),
            strip1.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            ppmMaxField.topAnchor.constraint(equalTo: ppmMinField.topAnchor),
            ppmMaxField.leftAnchor.constraint(equalTo: strip1.rightAnchor, constant: 2),
            ppmMaxField.rightAnchor.constraint(equalTo: backgroundWhite.rightAnchor, constant: -16),
            ppmMaxField.widthAnchor.constraint(equalToConstant: 65),
            ppmMaxField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            phLabel.topAnchor.constraint(equalTo: ppmLabel.bottomAnchor, constant: 17),
            phLabel.leftAnchor.constraint(equalTo: backgroundWhite.leftAnchor, constant: 16),
            phLabel.widthAnchor.constraint(equalToConstant: 78),
            phLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            phMinField.topAnchor.constraint(equalTo: ppmMinField.bottomAnchor, constant: 10),
            phMinField.leftAnchor.constraint(equalTo: phLabel.rightAnchor, constant: 105),
            phMinField.widthAnchor.constraint(equalToConstant: 65),
            phMinField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            strip2.topAnchor.constraint(equalTo: phMinField.topAnchor, constant: 6),
            strip2.leftAnchor.constraint(equalTo: phMinField.rightAnchor, constant: 2),
            strip2.widthAnchor.constraint(equalToConstant: 9),
            strip2.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            phMaxField.topAnchor.constraint(equalTo: phMinField.topAnchor),
            phMaxField.leftAnchor.constraint(equalTo: strip2.rightAnchor, constant: 2),
            phMaxField.rightAnchor.constraint(equalTo: backgroundWhite.rightAnchor, constant: -16),
            phMaxField.widthAnchor.constraint(equalToConstant: 65),
            phMaxField.heightAnchor.constraint(equalToConstant: 34)
        ])
        
    }
    
}
