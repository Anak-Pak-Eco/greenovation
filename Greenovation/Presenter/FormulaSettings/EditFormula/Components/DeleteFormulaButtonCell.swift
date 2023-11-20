//
//  DeleteFormulaButtonCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 18/11/23.
//

import UIKit

class DeleteFormulaButtonCell: UITableViewCell {

    @IBOutlet weak var deleteFormulaButton: LocalizableButton!
    var delegate: EditFormulaDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteFormulaButton.setTitle(String(localized: "delete-formula"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func onDeleteFormulaButtonClicked(_ sender: Any) {
        delegate?.onDeleteFormulaClicked()
    }
}
