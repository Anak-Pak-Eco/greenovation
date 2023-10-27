//
//  CustomChooseFormulationView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 27/10/23.
//

import UIKit

final class CustomChooseFormulationView: UIView {
    
    let kailan = "Kailan"
    let phaseName = String(localized: "fase-anakan")
    
    var label: UILabel?
    var ppmLabel: UILabel?
    var ppmMinField: UITextField?
    var strip1: UILabel?
    var ppmMaxField: UITextField?
    var phLabel: UILabel?
    var phMinField: UITextField?
    var strip2: UILabel?
    var phMaxField: UITextField?
    
    let picker: UISegmentedControl = {
        let component = UISegmentedControl(items: ["formula-saya", "rekomendasi"])
        component.selectedSegmentIndex = 0
        component.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        component.backgroundColor = .secondaryContainer
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    func makeDesc(text: String, size: CGFloat) -> UILabel {
        let component = UILabel()
        component.text = text
        component.numberOfLines = 2
        component.font = UIFont.systemFont(ofSize: size)
        component.textColor = UIColor.onSurfaceLow
        component.adjustsFontSizeToFitWidth = true
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    func makeLabel(text: String, size: CGFloat) -> UILabel {
        let component = UILabel()
        component.text = text
        component.numberOfLines = 2
        component.font = UIFont.systemFont(ofSize: size)
        component.textColor = UIColor.black
        component.adjustsFontSizeToFitWidth = true
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
        
        self.addSubview(picker)
        
        label = makeDesc(text: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk **\(kailan)** pada **\(phaseName)**"), size: 12)
        ppmLabel = makeLabel(text: String(localized: "**Kepekatan Nutrisi** (ppm)"), size: 15)
        ppmMinField = makeTextField(text: String(localized: "750"))
        strip1 = makeLabel(text: "-", size: 17)
        ppmMaxField = makeTextField(text: "1200")
        phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
        phMinField = makeTextField(text: "5.5")
        strip2 = makeLabel(text: "-", size: 17)
        phMaxField = makeTextField(text: "7.5")
        
        // Add View
        self.addSubview(label!)
        self.addSubview(ppmLabel!)
        self.addSubview(ppmMinField!)
        self.addSubview(strip1!)
        self.addSubview(ppmMaxField!)
        self.addSubview(phLabel!)
        self.addSubview(phMinField!)
        self.addSubview(strip2!)
        self.addSubview(phMaxField!)
        
        Layout()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            
            // Remove if exist
            label?.removeFromSuperview()
            ppmLabel?.removeFromSuperview()
            ppmMinField?.removeFromSuperview()
            strip1?.removeFromSuperview()
            ppmMaxField?.removeFromSuperview()
            phLabel?.removeFromSuperview()
            phMinField?.removeFromSuperview()
            strip2?.removeFromSuperview()
            phMaxField?.removeFromSuperview()
            
            label = makeDesc(text: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk **\(kailan)** pada **\(phaseName)**"), size: 12)
            ppmLabel = makeLabel(text: String(localized: "**Kepekatan Nutrisi** (ppm)"), size: 15)
            ppmMinField = makeTextField(text: String(localized: "750"))
            strip1 = makeLabel(text: "-", size: 17)
            ppmMaxField = makeTextField(text: "1200")
            phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
            phMinField = makeTextField(text: "5.5")
            strip2 = makeLabel(text: "-", size: 17)
            phMaxField = makeTextField(text: "7.5")
            
            // Add View
            self.addSubview(label!)
            self.addSubview(ppmLabel!)
            self.addSubview(ppmMinField!)
            self.addSubview(strip1!)
            self.addSubview(ppmMaxField!)
            self.addSubview(phLabel!)
            self.addSubview(phMinField!)
            self.addSubview(strip2!)
            self.addSubview(phMaxField!)
            
            Layout()
            
        case 1:
            
            // Remove if exist
            label?.removeFromSuperview()
            ppmLabel?.removeFromSuperview()
            ppmMinField?.removeFromSuperview()
            strip1?.removeFromSuperview()
            ppmMaxField?.removeFromSuperview()
            phLabel?.removeFromSuperview()
            phMinField?.removeFromSuperview()
            strip2?.removeFromSuperview()
            phMaxField?.removeFromSuperview()
            
            label = makeDesc(text: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk **\(kailan)** pada **\(phaseName)**"), size: 12)
            ppmLabel = makeLabel(text: String(localized: "**Kepekatan Nutrisi** (ppm)"), size: 15)
            ppmMinField = makeTextField(text: String(localized: "900"))
            strip1 = makeLabel(text: "-", size: 17)
            ppmMaxField = makeTextField(text: "1200")
            phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
            phMinField = makeTextField(text: "5.5")
            strip2 = makeLabel(text: "-", size: 17)
            phMaxField = makeTextField(text: "6.5")
            
            // Add View
            self.addSubview(label!)
            self.addSubview(ppmLabel!)
            self.addSubview(ppmMinField!)
            self.addSubview(strip1!)
            self.addSubview(ppmMaxField!)
            self.addSubview(phLabel!)
            self.addSubview(phMinField!)
            self.addSubview(strip2!)
            self.addSubview(phMaxField!)
            
            Layout()
        default:
            break
        }
    }
    
    func Layout() {
        NSLayoutConstraint.activate([
            label!.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 15),
            label!.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            label!.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            label!.widthAnchor.constraint(equalToConstant: 358),
            label!.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            ppmLabel!.topAnchor.constraint(equalTo: label!.bottomAnchor, constant: 22),
            ppmLabel!.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 15),
            ppmLabel!.widthAnchor.constraint(equalToConstant: 183),
            ppmLabel!.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            ppmMinField!.topAnchor.constraint(equalTo: label!.bottomAnchor, constant: 15),
            ppmMinField!.leftAnchor.constraint(equalTo: ppmLabel!.rightAnchor, constant: 30),
            ppmMinField!.widthAnchor.constraint(equalToConstant: 65),
            ppmMinField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            strip1!.topAnchor.constraint(equalTo: ppmMinField!.topAnchor, constant: 6),
            strip1!.leftAnchor.constraint(equalTo: ppmMinField!.rightAnchor, constant: 2),
            strip1!.widthAnchor.constraint(equalToConstant: 9),
            strip1!.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            ppmMaxField!.topAnchor.constraint(equalTo: ppmMinField!.topAnchor),
            ppmMaxField!.leftAnchor.constraint(equalTo: strip1!.rightAnchor, constant: 2),
            ppmMaxField!.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -19),
            ppmMaxField!.widthAnchor.constraint(equalToConstant: 65),
            ppmMaxField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            phLabel!.topAnchor.constraint(equalTo: ppmLabel!.bottomAnchor, constant: 17),
            phLabel!.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 15),
            phLabel!.widthAnchor.constraint(equalToConstant: 79),
            phLabel!.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            phMinField!.topAnchor.constraint(equalTo: ppmMinField!.bottomAnchor, constant: 10),
            phMinField!.leftAnchor.constraint(equalTo: phLabel!.rightAnchor, constant: 134),
            phMinField!.widthAnchor.constraint(equalToConstant: 65),
            phMinField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            strip2!.topAnchor.constraint(equalTo: phMinField!.topAnchor, constant: 6),
            strip2!.leftAnchor.constraint(equalTo: phMinField!.rightAnchor, constant: 2),
            strip2!.widthAnchor.constraint(equalToConstant: 9),
            strip2!.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        NSLayoutConstraint.activate([
            phMaxField!.topAnchor.constraint(equalTo: phMinField!.topAnchor),
            phMaxField!.leftAnchor.constraint(equalTo: strip2!.rightAnchor, constant: 2),
            phMaxField!.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -19),
            phMaxField!.widthAnchor.constraint(equalToConstant: 65),
            phMaxField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            picker.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 15),
            picker.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -17),
        ])
    }
    
}
