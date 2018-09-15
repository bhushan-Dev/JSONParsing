//
//  TableViewCell.swift
//  JSONParsing
//
//  Created by Bhushan Udawant on 15/09/18.
//  Copyright © 2018 Bhushan Udawant. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
