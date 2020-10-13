//
//  ReminderTableViewCell.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/1/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var remindLabel: UILabel!
    
    @IBOutlet weak var remindDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.clipsToBounds = false
        containerView.layer.cornerRadius = 10
        self.selectedBackgroundView?.backgroundColor = .red
        self.multipleSelectionBackgroundView?.backgroundColor = .green
//        self.selectedBackgroundView = UIView().backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
