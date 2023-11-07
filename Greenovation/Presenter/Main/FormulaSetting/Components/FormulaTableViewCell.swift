//
//  FormulaTableViewCell.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 06/11/23.
//

import UIKit

class FormulaTableViewCell: UITableViewCell {
    
    @IBOutlet var formulaImage: UIImageView!
    @IBOutlet var formulaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
