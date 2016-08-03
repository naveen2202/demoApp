//
//  RecieverCell.swift
//  demoApp
//
//  Created by ATPL on 8/2/16.
//  Copyright © 2016 ATPL. All rights reserved.
//

import UIKit

class RecieverCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
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
