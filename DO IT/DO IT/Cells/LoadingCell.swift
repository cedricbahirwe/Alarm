//
//  LoadingCell.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
