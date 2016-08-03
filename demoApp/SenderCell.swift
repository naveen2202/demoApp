//
//  SenderCell.swift
//  demoApp
//
//  Created by ATPL on 8/2/16.
//  Copyright © 2016 ATPL. All rights reserved.
//

import UIKit

class SenderCell: UITableViewCell {

    @IBOutlet weak var senderMessage: UILabel!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var bubble: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
