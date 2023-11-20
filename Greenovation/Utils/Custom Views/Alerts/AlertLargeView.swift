//
//  AlertLargeView.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 02/11/23.
//

import UIKit

@IBDesignable
class AlertLargeView: UIView {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var didClickOnDeleteButton: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setText(title: String, description: String) {
        print(title)
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    func setText(title: NSMutableAttributedString, description: NSMutableAttributedString) {
        titleLabel.attributedText = title
        descriptionLabel.attributedText = description
    }
    
    private func setup() {
        view = loadViewFromNib()
        view.frame = bounds
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
    
    @IBAction func onDoneButtonClicked(_ sender: Any) {
        didClickOnDeleteButton?()
    }
}
