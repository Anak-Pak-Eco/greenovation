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
    
    let isHave = true
    
    var label: UILabel?
    var ppmLabel: UILabel?
    var ppmMinField: UITextField?
    var strip1: UILabel?
    var ppmMaxField: UITextField?
    var phLabel: UILabel?
    var phMinField: UITextField?
    var strip2: UILabel?
    var phMaxField: UITextField?
    var saveButton: UIButton?
    
    let backgroundView: UIView = {
        let component = UIView()
        component.backgroundColor = UIColor.surface
        component.layer.cornerRadius = 10.0
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
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
    
    func makeTextField(text: String, color: UIColor) -> UITextField {
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
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: color]
        let attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
        component.attributedPlaceholder = attributedPlaceholder
        return component
    }
    
    func makeButtonEnable() -> UIButton {
        let component = UIButton()
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = UIColor.primaryAccent
        component.layer.cornerRadius = 10.0
        component.setTitle(String(localized: "simpan-pilihan"), for: .normal)
        component.isEnabled = true
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    func makeButtonDisabled() -> UIButton {
        let component = UIButton()
        component.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        component.backgroundColor = UIColor.surfaceContainerHighest
        component.layer.cornerRadius = 10.0
        component.setTitle(String(localized: "simpan-pilihan"), for: .normal)
        component.isEnabled = false
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }
    
    let title: UILabel = {
        let component = UILabel()
        component.text = String(localized: "pilih-satu-formula")
        component.font = UIFont.boldSystemFont(ofSize: 25)
        component.adjustsFontSizeToFitWidth = true
        component.textAlignment = .left
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: 169).isActive = true
        component.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return component
    } ()
    
    let dismis: UIButton = {
        let component = UIButton()
        component.setBackgroundImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: 30).isActive = true
        component.heightAnchor.constraint(equalToConstant: 30).isActive = true
        component.addTarget(self, action: #selector(handleDismissTap), for: .touchUpInside)
        return component
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout(0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout(0)
    }
    
    func buildLayout(_ selectedSegmentIndex: Int) {
        self.layer.cornerRadius = 10.0
        
        switch selectedSegmentIndex {
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
            
            if isHave {
                label = makeDesc(text: String(localized: "Formula di bawah ini merupakan formula yang kamu buat untuk **\(kailan)** pada **\(phaseName)**"), size: 12)
                ppmMinField = makeTextField(text: String(localized: "750"), color: .black)
                ppmMaxField = makeTextField(text: "1200", color: .black)
                phMinField = makeTextField(text: "5.5", color: .black)
                phMaxField = makeTextField(text: "7.5", color: .black)
                saveButton = makeButtonEnable()
            } else {
                label = makeDesc(text: String(localized: "Kamu belum pernah membuat formula untuk Jenis Tanaman dan Tahap Pertumbuhan ini. Silahkan buat."), size: 12)
                ppmMinField = makeTextField(text: String(localized: "Min"), color: .gray)
                ppmMaxField = makeTextField(text: "Max", color: .gray)
                phMinField = makeTextField(text: "Min", color: .gray)
                phMaxField = makeTextField(text: "Max", color: .gray)
                saveButton = makeButtonDisabled()
            }
            ppmLabel = makeLabel(text: String(localized: "**Kepekatan Nutrisi** (ppm)"), size: 15)
            strip1 = makeLabel(text: "-", size: 17)
            phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
            strip2 = makeLabel(text: "-", size: 17)
            
            saveButton?.addTarget(self, action: #selector(saveButtonDidTap(_:)), for: .touchUpInside)
            
            // Add View
            self.addSubview(backgroundView)
            self.addSubview(title)
            self.addSubview(dismis)
            self.addSubview(picker)
            self.addSubview(label!)
            self.addSubview(ppmLabel!)
            self.addSubview(ppmMinField!)
            self.addSubview(strip1!)
            self.addSubview(ppmMaxField!)
            self.addSubview(phLabel!)
            self.addSubview(phMinField!)
            self.addSubview(strip2!)
            self.addSubview(phMaxField!)
            self.addSubview(saveButton!)
            
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
            ppmMinField = makeTextField(text: String(localized: "900"), color: .black)
            strip1 = makeLabel(text: "-", size: 17)
            ppmMaxField = makeTextField(text: "1200", color: .black)
            phLabel = makeLabel(text: String(localized: "**Tingkat pH**"), size: 15)
            phMinField = makeTextField(text: "5.5", color: .black)
            strip2 = makeLabel(text: "-", size: 17)
            phMaxField = makeTextField(text: "6.5", color: .black)
            saveButton = makeButtonEnable()
            
            saveButton?.addTarget(self, action: #selector(saveButtonDidTap(_:)), for: .touchUpInside)
            
            // Add View
            self.addSubview(backgroundView)
            self.addSubview(title)
            self.addSubview(dismis)
            self.addSubview(picker)
            self.addSubview(label!)
            self.addSubview(ppmLabel!)
            self.addSubview(ppmMinField!)
            self.addSubview(strip1!)
            self.addSubview(ppmMaxField!)
            self.addSubview(phLabel!)
            self.addSubview(phMinField!)
            self.addSubview(strip2!)
            self.addSubview(phMaxField!)
            self.addSubview(saveButton!)
            
            Layout()
        default:
            break
        }
        
        Layout()
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        buildLayout(sender.selectedSegmentIndex)
        
    }
    
    @objc func handleDismissTap() {
        SharedData.shared.isBottomSheetVisible.value = false
        SharedData.shared.bottomSheetSecondShow = false
        self.removeFromSuperview()
    }
    
    @objc func saveButtonDidTap(_ button: UIButton) {
        SharedData.shared.isDone.value = true
        SharedData.shared.isBottomSheetVisible.value = false
        SharedData.shared.bottomSheetSecondShow = false
        self.removeFromSuperview()
    }
    
    func Layout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20.5),
            title.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            dismis.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 18),
            dismis.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -13)
        ])
        
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 22.5),
            picker.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 15),
            picker.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -17),
        ])
        
        NSLayoutConstraint.activate([
            label!.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 15),
            label!.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16),
            label!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16),
            label!.widthAnchor.constraint(equalToConstant: 358),
            label!.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            ppmLabel!.topAnchor.constraint(equalTo: label!.bottomAnchor, constant: 22),
            ppmLabel!.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 15),
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
            ppmMaxField!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -19),
            ppmMaxField!.widthAnchor.constraint(equalToConstant: 65),
            ppmMaxField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            phLabel!.topAnchor.constraint(equalTo: ppmLabel!.bottomAnchor, constant: 17),
            phLabel!.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 15),
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
            phMaxField!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -19),
            phMaxField!.widthAnchor.constraint(equalToConstant: 65),
            phMaxField!.heightAnchor.constraint(equalToConstant: 34)
        ])
        
        NSLayoutConstraint.activate([
            saveButton!.topAnchor.constraint(equalTo: ppmMinField!.bottomAnchor, constant: 91),
            saveButton!.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16),
            saveButton!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -16)
        ])
    }
    
}
