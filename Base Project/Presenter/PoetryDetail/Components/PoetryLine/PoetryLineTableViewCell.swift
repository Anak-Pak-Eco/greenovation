//
//  PoetryLineTableViewCell.swift
//  Base Project
//
//  Created by Naufal Fawwaz Andriawan on 05/10/23.
//

import UIKit

class PoetryLineTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var poetryLineLabel: UILabel!

    func setPoetryLine(_ poetryLine: String) {
        poetryLineLabel.text = poetryLine
    }
}
