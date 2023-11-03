//
//  LocalizationStoryboard.swift
//  Greenovation
//
//  Created by Leonardo Jose Gunawan on 25/10/23.
//

import UIKit

final class LocalizableLabel: UILabel {
    @IBInspectable var localizedKey: String? {
        didSet {
            guard let key = localizedKey else { return }
            text = NSLocalizedString(key, comment: "")
        }
    }
}

final class LocalizableButton: UIButton {
    @IBInspectable var localizedKey: String? {
        didSet {
            guard let key = localizedKey else { return }
            setTitle(NSLocalizedString(key, comment: ""), for: .normal)
        }
    }
}
