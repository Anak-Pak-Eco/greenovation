//
//  CustomGrowthStepView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 26/10/23.
//

import UIKit

final class CustomGrowthStepView: UIView {
//    let sharedData = SharedData.shared
    
    var title: UILabel?
    var dismis: UIButton?
    var stackViewContainer: UIView?
    var stackViewContainer2: UIView?
    var stackViewContainer3: UIView?
    var imageViewContainer: UIImageView?
    var titleLabelContainer: UILabel?
    var descriptionContainer: UILabel?
    var circleImage: UIImageView?
    var imageViewContainer2: UIImageView?
    var titleLabelContainer2: UILabel?
    var descriptionContainer2: UILabel?
    var circleImage2: UIImageView?
    var imageViewContainer3: UIImageView?
    var titleLabelContainer3: UILabel?
    var descriptionContainer3: UILabel?
    var circleImage3: UIImageView?
    
    let backgroundView: UIView = {
        let component = UIView()
        component.backgroundColor = UIColor.surface
        component.layer.cornerRadius = 10.0
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    let stackView: UIStackView = {
        let component = UIStackView()
        component.axis = NSLayoutConstraint.Axis.vertical
        component.distribution = UIStackView.Distribution.fillEqually
        component.alignment = UIStackView.Alignment.center
        component.backgroundColor = .surface
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    func makeStackViewContainer(height: CGFloat, tag: Int) -> UIView {
        let component = UIView()
        component.backgroundColor = .clear
        component.tag = tag // Assign a unique tag to each container
        component.translatesAutoresizingMaskIntoConstraints = false
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStackViewContainerTap(_:)))
        component.addGestureRecognizer(tapGesture)
        component.isUserInteractionEnabled = true
        return component
    }
    
    @objc func handleStackViewContainerTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view, let index = stackView.arrangedSubviews.firstIndex(of: view) else {
            return
        }
        
        switch index {
        case 0:
            showSecondBottom()
            
            print("Tapped on the first container")
        case 1:
            showSecondBottom()
            
            print("Tapped on the second container")
        case 2:
            showSecondBottom()
            
            print("Tapped on the third container")
        default:
            break
        }
    }
    
    func showSecondBottom() {
        SharedData.shared.bottomSheetSecondShow = true

        let secondView = CustomChooseFormulationView()
        secondView.translatesAutoresizingMaskIntoConstraints = false
//            self.addSubview(backgroundView)
        self.addSubview(secondView)
        
        NSLayoutConstraint.activate([
            secondView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            secondView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            secondView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            secondView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makePicture(imageName: String, width: CGFloat, height: CGFloat) -> UIImageView {
        let component = UIImageView()
        component.image = UIImage(named: imageName)
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: width).isActive = true
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        return component
    }
    
    func makeTitleLabel(text: String, width: CGFloat, height: CGFloat, size: CGFloat) -> UILabel {
        let component = UILabel()
        component.text = text
        component.font = UIFont.boldSystemFont(ofSize: size)
        component.adjustsFontSizeToFitWidth = true
        component.textAlignment = .left
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: width).isActive = true
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        return component
    }
    
    func makeDescriptionLabel(text: String, width: CGFloat, height: CGFloat, nol: Int) -> UILabel {
        let component = UILabel()
        component.text = text
        component.numberOfLines = nol
        component.font = UIFont.systemFont(ofSize: 13)
        component.adjustsFontSizeToFitWidth = true
        component.textAlignment = .left
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: width).isActive = true
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        return component
    }
    
    func makeDismiss() -> UIButton {
        let component = UIButton()
        component.setBackgroundImage(UIImage(systemName: "x.circle.fill"), for: .normal)
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: 30).isActive = true
        component.heightAnchor.constraint(equalToConstant: 30).isActive = true
        component.addTarget(self, action: #selector(handleDismissTap), for: .touchUpInside)
        return component
    }
    
    @objc func handleDismissTap() {
        SharedData.shared.isBottomSheetVisible.value = false
        self.removeFromSuperview()
    }
    
    func animateBottomSheet(toY: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = toY
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SharedData.shared.isBottomSheetVisible.bind { [weak self] isVisible in
            guard let self = self else { return }
            if SharedData.shared.isBottomSheetVisible.value == false {
                self.removeFromSuperview()
            }
        }
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        SharedData.shared.isBottomSheetVisible.bind { [weak self] isVisible in
            guard let self = self else { return }
            if SharedData.shared.isBottomSheetVisible.value == false {
                self.removeFromSuperview()
            }
        }
        buildLayout()
    }
    
    func buildLayout() {
        title = makeTitleLabel(text: String(localized: "tahap-pertumbuhan"), width: 198, height: 25, size: 20)
        dismis = makeDismiss()
        stackViewContainer = makeStackViewContainer(height: 77, tag: 0)
        stackViewContainer2 = makeStackViewContainer(height: 77, tag: 1)
        stackViewContainer3 = makeStackViewContainer(height: 95, tag: 2)
        // MARK: Container 1
        imageViewContainer = makePicture(imageName: "image-anakan-growthstep", width: 61, height: 61)
        titleLabelContainer = makeTitleLabel(text: String(localized: "fase-anakan"), width: 100, height: 21, size: 16)
        descriptionContainer = makeDescriptionLabel(text: String(localized: "Fase dimulai dari benih dan berlanjut dengan tanaman mulai mengembangkan daun sejati."), width: 259, height: 36, nol: 2)
        circleImage = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        // MARK: Container 2
        imageViewContainer2 = makePicture(imageName: "image-awal-growthstep", width: 61, height: 61)
        titleLabelContainer2 = makeTitleLabel(text: String(localized: "fase-vegetatif-awal"), width: 154, height: 21, size: 16)
        descriptionContainer2 = makeDescriptionLabel(text: String(localized: "Tanaman mulai mempunyai akar yang kuat dan mengembangkan daun dan cabang."), width: 259, height: 36, nol: 2)
        circleImage2 = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        // MARK: Container 2
        imageViewContainer3 = makePicture(imageName: "image-menengah-growthstep", width: 61, height: 61)
        titleLabelContainer3 = makeTitleLabel(text: String(localized: "fase-vegetatif-menengah"), width: 198, height: 21, size: 16)
        descriptionContainer3 = makeDescriptionLabel(text: String(localized: "Tanaman mengalami pertumbuhan daun, batang, dan akar yang berlangsung dengan cepat hingga masa panen sayuran daun tiba."), width: 259, height: 54, nol: 3)
        circleImage3 = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        
        stackView.addArrangedSubview(stackViewContainer!)
        stackView.addArrangedSubview(stackViewContainer2!)
        stackView.addArrangedSubview(stackViewContainer3!)
        
        self.addSubview(backgroundView)
        self.addSubview(title!)
        self.addSubview(dismis!)
        self.addSubview(stackView)
        // MARK: Container 1
        self.addSubview(imageViewContainer!)
        self.addSubview(titleLabelContainer!)
        self.addSubview(descriptionContainer!)
        self.addSubview(circleImage!)
        // MARK: Container 2
        self.addSubview(imageViewContainer2!)
        self.addSubview(titleLabelContainer2!)
        self.addSubview(descriptionContainer2!)
        self.addSubview(circleImage2!)
        // MARK: Container 3
        self.addSubview(imageViewContainer3!)
        self.addSubview(titleLabelContainer3!)
        self.addSubview(descriptionContainer3!)
        self.addSubview(circleImage3!)
        
        Layout()
        
    }
    
    func Layout() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            title!.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20.5),
            title!.leftAnchor.constraint(equalTo: backgroundView.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            dismis!.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 18),
            dismis!.rightAnchor.constraint(equalTo: backgroundView.rightAnchor, constant: -13)
        ])
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title!.bottomAnchor, constant: 24.5),
            stackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 249)
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer!.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackViewContainer!.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer!.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer2!.topAnchor.constraint(equalTo: stackViewContainer!.bottomAnchor),
            stackViewContainer2!.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer2!.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer3!.topAnchor.constraint(equalTo: stackViewContainer2!.bottomAnchor),
            stackViewContainer3!.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer3!.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        // MARK: Container 1
        NSLayoutConstraint.activate([
            imageViewContainer!.topAnchor.constraint(equalTo: stackViewContainer!.topAnchor, constant: 8),
            imageViewContainer!.leftAnchor.constraint(equalTo: stackViewContainer!.leftAnchor, constant: 16),
            imageViewContainer!.bottomAnchor.constraint(equalTo: stackViewContainer!.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer!.topAnchor.constraint(equalTo: stackViewContainer!.topAnchor, constant: 8),
            titleLabelContainer!.leftAnchor.constraint(equalTo: imageViewContainer!.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer!.topAnchor.constraint(equalTo: titleLabelContainer!.bottomAnchor, constant: 4),
            descriptionContainer!.leftAnchor.constraint(equalTo: imageViewContainer!.rightAnchor, constant: 5),
            descriptionContainer!.bottomAnchor.constraint(equalTo: stackViewContainer!.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage!.topAnchor.constraint(equalTo: stackViewContainer!.topAnchor, constant: 26),
            circleImage!.rightAnchor.constraint(equalTo: stackViewContainer!.rightAnchor, constant: -16),
            circleImage!.bottomAnchor.constraint(equalTo: stackViewContainer!.bottomAnchor, constant: -26),
        ])
        
        // MARK: Container 2
        NSLayoutConstraint.activate([
            imageViewContainer2!.topAnchor.constraint(equalTo: stackViewContainer2!.topAnchor, constant: 8),
            imageViewContainer2!.leftAnchor.constraint(equalTo: stackViewContainer2!.leftAnchor, constant: 16),
            imageViewContainer2!.bottomAnchor.constraint(equalTo: stackViewContainer2!.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer2!.topAnchor.constraint(equalTo: stackViewContainer2!.topAnchor, constant: 8),
            titleLabelContainer2!.leftAnchor.constraint(equalTo: imageViewContainer2!.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer2!.topAnchor.constraint(equalTo: titleLabelContainer2!.bottomAnchor, constant: 4),
            descriptionContainer2!.leftAnchor.constraint(equalTo: imageViewContainer2!.rightAnchor, constant: 5),
            descriptionContainer2!.bottomAnchor.constraint(equalTo: stackViewContainer2!.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage2!.topAnchor.constraint(equalTo: stackViewContainer2!.topAnchor, constant: 26),
            circleImage2!.rightAnchor.constraint(equalTo: stackViewContainer2!.rightAnchor, constant: -16),
            circleImage2!.bottomAnchor.constraint(equalTo: stackViewContainer2!.bottomAnchor, constant: -26),
        ])
        
        // MARK: Container 3
        NSLayoutConstraint.activate([
            imageViewContainer3!.topAnchor.constraint(equalTo: stackViewContainer3!.topAnchor, constant: 8),
            imageViewContainer3!.leftAnchor.constraint(equalTo: stackViewContainer3!.leftAnchor, constant: 16),
            imageViewContainer3!.bottomAnchor.constraint(equalTo: stackViewContainer3!.bottomAnchor, constant: -26),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer3!.topAnchor.constraint(equalTo: stackViewContainer3!.topAnchor, constant: 8),
            titleLabelContainer3!.leftAnchor.constraint(equalTo: imageViewContainer3!.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer3!.topAnchor.constraint(equalTo: titleLabelContainer3!.bottomAnchor, constant: 4),
            descriptionContainer3!.leftAnchor.constraint(equalTo: imageViewContainer3!.rightAnchor, constant: 5),
            descriptionContainer3!.bottomAnchor.constraint(equalTo: stackViewContainer3!.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage3!.topAnchor.constraint(equalTo: stackViewContainer3!.topAnchor, constant: 35),
            circleImage3!.rightAnchor.constraint(equalTo: stackViewContainer3!.rightAnchor, constant: -16),
            circleImage3!.bottomAnchor.constraint(equalTo: stackViewContainer3!.bottomAnchor, constant: -35),
        ])
    }
    
}
