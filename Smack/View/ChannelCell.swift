//
//  ChannelCell.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-12.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var channelName: UILabel!
    
    /*
     Functions
     */
    
    
    // Awake From Nib Function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    // Set Selected Function.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // If a channel is selected, set up the view
        if selected {
            // Set background colour to White (1 being the most white) and opacity to .2 (very transparent)
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    
    // Configure Cell Function
    func configureCell(channel: Channel) {
        // Grab the channelTitle, ?? "" -> (or set to an empty String)
        let title = channel.channelTitle ?? ""
        
        // Set our Label to the channelTitle.
        channelName.text = title
    }
    
    
} // END Class





// ChannelCell: 













