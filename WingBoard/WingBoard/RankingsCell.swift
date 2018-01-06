//
//  RankingsCell.swift
//  WingBoard
//
//  Created by Bryan Marks on 9/6/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//

import UIKit
import StoreKit

class RankingsCell: UITableViewCell {
       override func prepareForReuse() {
        super.prepareForReuse()
        
        textLabel?.text = ""
        detailTextLabel?.text = ""
        accessoryView = nil
    }
    
  
}
