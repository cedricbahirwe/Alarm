//
//  AlarmTableViewCell.swift
//  DO IT
//
//  Created by Cedric Bahirwe on 8/2/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit


protocol LongPressed {
    func didLongPressView()
}

class AlarmTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var alarmStateSwitch: UISwitch!
    
    var delegate: LongPressed!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let longPress =  UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(sender:)))
        
        longPress.minimumPressDuration = 0.5
        longPress.cancelsTouchesInView = false
        self.addGestureRecognizer(longPress)
        containerView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func didLongPress(sender: UILongPressGestureRecognizer) {
        self.delegate.didLongPressView()
    }
    
    

}
