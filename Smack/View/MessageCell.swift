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
    } // End Awake From Nib.
    
    
    // Configure Cell
        //-> Set up the IB Outlets.
    func configureCell(message: Message) {
        messageBodyLbl.text = message.message
        userNameLbl.text = message.userName
        userImg.image = UIImage(named: message.userAvatar)
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
        
        // ISO-8601 Format is what we get back for date stamp.
            // 2017-07-13T21:49:25.590z
        
        guard var isoDate = message.timeStamp else { return }
        
        // Start at the end and backtrack by 5
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        
        // We now have an ISO fotmat without the milliseconds
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormtter = DateFormatter()
        
        // Tnhis sets a readable date pof M/D H:M and am/pm
        newFormtter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormtter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }
    } // End Configure Cell
    
    
} // END Class.



