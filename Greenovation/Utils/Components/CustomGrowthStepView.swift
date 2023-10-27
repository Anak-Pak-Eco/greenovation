//
//  CustomGrowthStepView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 26/10/23.
//

import UIKit

final class CustomGrowthStepView: UIView {
    
    let stackView: UIStackView = {
        let component = UIStackView()
        component.axis = NSLayoutConstraint.Axis.vertical
        component.distribution = UIStackView.Distribution.fillEqually
        component.alignment = UIStackView.Alignment.center
        component.backgroundColor = .surface
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    } ()
    
    func makeStackViewContainer(height: CGFloat) -> UIView {
        let component = UIView()
        component.backgroundColor = .clear
        component.translatesAutoresizingMaskIntoConstraints = false
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        return component
    }
    
    func makePicture(imageName: String, width: CGFloat, height: CGFloat) -> UIImageView {
        let component = UIImageView()
        component.image = UIImage(named: imageName)
        component.translatesAutoresizingMaskIntoConstraints = false
        component.widthAnchor.constraint(equalToConstant: width).isActive = true
        component.heightAnchor.constraint(equalToConstant: height).isActive = true
        return component
    }
    
    func makeTitleLabel(text: String, width: CGFloat, height: CGFloat) -> UILabel {
        let component = UILabel()
        component.text = text
        component.font = UIFont.boldSystemFont(ofSize: 16)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildLayout()
    }
    
    func buildLayout() {
        let stackViewContainer = makeStackViewContainer(height: 77)
        let stackViewContainer2 = makeStackViewContainer(height: 77)
        let stackViewContainer3 = makeStackViewContainer(height: 95)
        // MARK: Container 1
        let imageViewContainer = makePicture(imageName: "image-anakan-growthstep", width: 61, height: 61)
        let titleLabelContainer = makeTitleLabel(text: String(localized: "fase-anakan"), width: 100, height: 21)
        let descriptionContainer = makeDescriptionLabel(text: String(localized: "Fase dimulai dari benih dan berlanjut dengan tanaman mulai mengembangkan daun sejati."), width: 259, height: 36, nol: 2)
        let circleImage = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        // MARK: Container 2
        let imageViewContainer2 = makePicture(imageName: "image-awal-growthstep", width: 61, height: 61)
        let titleLabelContainer2 = makeTitleLabel(text: String(localized: "fase-vegetatif-awal"), width: 154, height: 21)
        let descriptionContainer2 = makeDescriptionLabel(text: String(localized: "Tanaman mulai mempunyai akar yang kuat dan mengembangkan daun dan cabang."), width: 259, height: 36, nol: 2)
        let circleImage2 = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        // MARK: Container 2
        let imageViewContainer3 = makePicture(imageName: "image-menengah-growthstep", width: 61, height: 61)
        let titleLabelContainer3 = makeTitleLabel(text: String(localized: "fase-vegetatif-menengah"), width: 198, height: 21)
        let descriptionContainer3 = makeDescriptionLabel(text: String(localized: "Tanaman mengalami pertumbuhan daun, batang, dan akar yang berlangsung dengan cepat hingga masa panen sayuran daun tiba."), width: 259, height: 54, nol: 3)
        let circleImage3 = makePicture(imageName: "image-circle-growth", width: 25, height: 25)
        
        stackView.addArrangedSubview(stackViewContainer)
        stackView.addArrangedSubview(stackViewContainer2)
        stackView.addArrangedSubview(stackViewContainer3)
        
        self.addSubview(stackView)
        // MARK: Container 1
        self.addSubview(imageViewContainer)
        self.addSubview(titleLabelContainer)
        self.addSubview(descriptionContainer)
        self.addSubview(circleImage)
        // MARK: Container 2
        self.addSubview(imageViewContainer2)
        self.addSubview(titleLabelContainer2)
        self.addSubview(descriptionContainer2)
        self.addSubview(circleImage2)
        // MARK: Container 3
        self.addSubview(imageViewContainer3)
        self.addSubview(titleLabelContainer3)
        self.addSubview(descriptionContainer3)
        self.addSubview(circleImage3)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: stackView.topAnchor),
            stackViewContainer.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer2.topAnchor.constraint(equalTo: stackViewContainer.bottomAnchor),
            stackViewContainer2.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer2.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            stackViewContainer3.topAnchor.constraint(equalTo: stackViewContainer2.bottomAnchor),
            stackViewContainer3.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            stackViewContainer3.rightAnchor.constraint(equalTo: stackView.rightAnchor),
        ])
        
        // MARK: Container 1
        NSLayoutConstraint.activate([
            imageViewContainer.topAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: 8),
            imageViewContainer.leftAnchor.constraint(equalTo: stackViewContainer.leftAnchor, constant: 16),
            imageViewContainer.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer.topAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: 8),
            titleLabelContainer.leftAnchor.constraint(equalTo: imageViewContainer.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer.topAnchor.constraint(equalTo: titleLabelContainer.bottomAnchor, constant: 4),
            descriptionContainer.leftAnchor.constraint(equalTo: imageViewContainer.rightAnchor, constant: 5),
            descriptionContainer.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage.topAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: 26),
            circleImage.rightAnchor.constraint(equalTo: stackViewContainer.rightAnchor, constant: -16),
            circleImage.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: -26),
        ])
        
        // MARK: Container 2
        NSLayoutConstraint.activate([
            imageViewContainer2.topAnchor.constraint(equalTo: stackViewContainer2.topAnchor, constant: 8),
            imageViewContainer2.leftAnchor.constraint(equalTo: stackViewContainer2.leftAnchor, constant: 16),
            imageViewContainer2.bottomAnchor.constraint(equalTo: stackViewContainer2.bottomAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer2.topAnchor.constraint(equalTo: stackViewContainer2.topAnchor, constant: 8),
            titleLabelContainer2.leftAnchor.constraint(equalTo: imageViewContainer2.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer2.topAnchor.constraint(equalTo: titleLabelContainer2.bottomAnchor, constant: 4),
            descriptionContainer2.leftAnchor.constraint(equalTo: imageViewContainer2.rightAnchor, constant: 5),
            descriptionContainer2.bottomAnchor.constraint(equalTo: stackViewContainer2.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage2.topAnchor.constraint(equalTo: stackViewContainer2.topAnchor, constant: 26),
            circleImage2.rightAnchor.constraint(equalTo: stackViewContainer2.rightAnchor, constant: -16),
            circleImage2.bottomAnchor.constraint(equalTo: stackViewContainer2.bottomAnchor, constant: -26),
        ])
        
        // MARK: Container 3
        NSLayoutConstraint.activate([
            imageViewContainer3.topAnchor.constraint(equalTo: stackViewContainer3.topAnchor, constant: 8),
            imageViewContainer3.leftAnchor.constraint(equalTo: stackViewContainer3.leftAnchor, constant: 16),
            imageViewContainer3.bottomAnchor.constraint(equalTo: stackViewContainer3.bottomAnchor, constant: -26),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelContainer3.topAnchor.constraint(equalTo: stackViewContainer3.topAnchor, constant: 8),
            titleLabelContainer3.leftAnchor.constraint(equalTo: imageViewContainer3.rightAnchor, constant: 5),
        ])
        
        NSLayoutConstraint.activate([
            descriptionContainer3.topAnchor.constraint(equalTo: titleLabelContainer3.bottomAnchor, constant: 4),
            descriptionContainer3.leftAnchor.constraint(equalTo: imageViewContainer3.rightAnchor, constant: 5),
            descriptionContainer3.bottomAnchor.constraint(equalTo: stackViewContainer3.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            circleImage3.topAnchor.constraint(equalTo: stackViewContainer3.topAnchor, constant: 35),
            circleImage3.rightAnchor.constraint(equalTo: stackViewContainer3.rightAnchor, constant: -16),
            circleImage3.bottomAnchor.constraint(equalTo: stackViewContainer3.bottomAnchor, constant: -35),
        ])
        
    }
    
}
