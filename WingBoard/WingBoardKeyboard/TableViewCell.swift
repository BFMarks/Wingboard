//
//  TableViewCell.swift
//  MorseCode
//
//  Created by Bryan Marks on 8/3/16.
//  Copyright © 2016 Bryan Marks. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
     
    @IBOutlet weak var label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
