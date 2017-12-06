//
//  ChannelVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-05.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the Toggle of ChatVC smaller when toggled to the right; so we can see Channel VC more.
            // .width - 60 means we only want to see 60 points of the ChatVC when toggled.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// ChannelVC:  


