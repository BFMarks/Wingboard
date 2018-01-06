//
//  WingboardCategory.swift
//  WingBoard
//
//  Created by Bryan Marks on 10/27/16.
//  Copyright © 2016 Bryan F. Marks. All rights reserved.
//

import Foundation
import UIKit

class WingboardCategory {
    let id: Int;
    let name: String;
    
    init(name: String, id: Int) {
        self.id = id;
        self.name = name;
    }
}
