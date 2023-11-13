//
//  BottomSheetView.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 30/10/23.
//

import UIKit

final class BottomSheetView: UIView {
    
    let sharedData = SharedData.shared
    
    var bottomFirstView: CustomGrowthStepView!
    var bottomSecondView: CustomChooseFormulationView!
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    func setView() {
        
        self.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        bottomFirstView = CustomGrowthStepView()
        bottomSecondView = CustomChooseFormulationView()

        containerView.subviews.forEach { $0.removeFromSuperview() }
            
        if sharedData.bottomSheetSecondShow {
            // Add the second view to the container
            containerView.addSubview(bottomSecondView)
            bottomSecondView.Layout()
        } else {
            // Add the first view to the container
            containerView.addSubview(bottomFirstView)
            bottomFirstView.Layout()
        }
        
    }
    
}
