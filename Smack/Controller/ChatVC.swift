//
//  ChatVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-05.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var menuBtn: UIButton!
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Click on button and slides the ChatVC to the right-> revealing the channelVC behind it.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // Use your finger to slide the chatVC instead of having to click the button.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Tap on the Chat while it's toggled to the right and it returns you to the ChatVC.
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // Check if logged in, if we are send out Notification User data has changed.
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
        MessageService.instance.findAllChannel { (success) in
            
        }
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

// ChatVC:  



















