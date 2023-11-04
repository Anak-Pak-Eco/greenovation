//
//  NotificationItemTableViewCell.swift
//  Greenovation
//
//  Created by Naufal Fawwaz Andriawan on 04/11/23.
//

import UIKit

class NotificationItemTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(notification: NotificationModel) {
        titleLabel.text = notification.title
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        timeLabel.text = formatter.string(from: notification.created_date)
        descriptionLabel.text = notification.body
    }
}
