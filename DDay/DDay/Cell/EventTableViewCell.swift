//
//  EventTableViewCell.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
