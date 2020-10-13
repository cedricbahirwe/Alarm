//
//  LapTimeTableViewCell.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class LapTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var lapCount: UILabel!
    @IBOutlet weak var lapTimeLabel: UILabel!
    @IBOutlet weak var overallTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
