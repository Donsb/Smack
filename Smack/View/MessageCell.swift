//
//  MessageCell.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-13.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    
    
    /*
     Functions
     */
    
    
    // Awake From Nib Function.
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    // Set Selected Function
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}



// MessageCell:  



















