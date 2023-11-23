//
//  SubmitButtonTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 17/11/23.
//

import UIKit

class SubmitButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    var delegate: RegisterFormulaDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        submitButton.setAttributedTitle(
            String.getStringAttributed(
                from: String(localized: "save"),
                regularTextStyle: UIFont(name: "DMSans-SemiBold", size: 17)!,
                textColor: .onPrimaryAccent
            ),
            for: .normal
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onSubmitButtonClicked(_ sender: Any) {
        delegate?.onSubmit()
    }
}
