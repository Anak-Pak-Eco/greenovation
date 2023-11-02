//
//  AlertView.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 01/11/23.
//

import UIKit

@IBDesignable
class AlertView: UIView {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertTextLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setLabel(_ label: String) {
        alertTextLabel.text = label
    }
    
    func setLabel(_ label: NSMutableAttributedString) {
        alertTextLabel.attributedText = label
    }
    
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
        // view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        alertView.layer.cornerRadius = 8
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView

        return nibView
    }
}
