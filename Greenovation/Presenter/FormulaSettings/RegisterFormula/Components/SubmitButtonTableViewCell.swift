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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onSubmitButtonClicked(_ sender: Any) {
        delegate?.onSubmit()
    }
}
