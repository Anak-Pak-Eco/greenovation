//
//  AuthorCell.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 01/10/23.
//

import Foundation
import UIKit

class AuthorCell: UITableViewCell {
    
    @IBOutlet private weak var authorTitleLabel: UILabel!
    
    func setAuthorLabel(author: String) {
        authorTitleLabel.text = "A poem by \(author)"
    }
}
