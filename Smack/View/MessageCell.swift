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
    
    
    // Configure Cell
        //-> Set up the IB Outlets.
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        // Time Label- will code in next lesson.
    }
    
    
    
}



// MessageCell:  



















