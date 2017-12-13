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
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind our View to the bottom of the keyboard.
        view.bindToKeyboard()
        
        // Ability to dismiss the keyboard by tapping outside it.
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        
        // Add that above ability to our view.
        view.addGestureRecognizer(tap)
        
        // Click on button and slides the ChatVC to the right-> revealing the channelVC behind it.
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        // Use your finger to slide the chatVC instead of having to click the button.
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Tap on the Chat while it's toggled to the right and it returns you to the ChatVC.
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        // Observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // Check if logged in, if we are send out Notification User data has changed.
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail(completion: { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
            })
        }
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // User Data Did Change Function.
    @objc func userDataDidChange(_ notif: Notification) {
        if AuthService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLbl.text = "Please Log In"
        }
    }
    
    
    //
    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                
                // Verify that there are channels as can't fetch messages if none exist.
                if MessageService.instance.channels.count > 0 {
                    
                    // If there is at least 1 channel, by default show the first one in the Array.
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    
                    // Set Channel Name Label
                    self.channelNameLbl.text = "No channels yet!"
                    
                }
            }
        }
    }
    
    
    // Channel Selected Function
    @objc func channelSelected(_ notif: Notification) {
        updateWithChannel()
    }
    
    
    // Update With Channel Function
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        channelNameLbl.text = "#\(channelName)"
        
        // Call Get Messages Function.
        getMessages()
    }
    
    
    // Handle Tap Function.
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    // Get Messages Function
    func getMessages() {
        
        // unwrap the needed channelID
        guard let channelId = MessageService.instance.selectedChannel?.id else { return }
        
        //Get Messages from Messages MessagesService
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            
        }
        
    }
    
    
    // Send Message Pressed Function
    @IBAction func sendMessagePressed(_ sender: Any) {
        
    }
    
    
}

// ChatVC:  



















