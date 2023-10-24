//
//  LocalizedStringKeyStoryboard.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 24/10/23.
//

import Foundation
import UIKit

final class LocalizableLabel: UILabel {
    
    @IBInspectable var localizedKey: String? {
        didSet {
            guard let key = localizedKey else { return }
            text = NSLocalizedString(key, comment: "")
        }
    }

}
