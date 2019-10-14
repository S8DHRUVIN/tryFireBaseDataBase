//
//  ItemTableViewCell.swift
//  FireBaseDataBase
//
//  Created by Dhruvin Shiyani on 25/09/19.
//  Copyright © 2019 Dhruvin Shiyani. All rights reserved.
//

import UIKit
import Firebase

class ItemTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblItemCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
