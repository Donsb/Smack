//
//  ChatVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-05.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTextBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Bind our View to the bottom of the keyboard.
        view.bindToKeyboard()
        
        // Set Delegate and DataSource to self.
        tableView.delegate = self
        tableView.dataSource = self
        
        //  Set estimated table row height, so we can change it based on message size.
        tableView.estimatedRowHeight = 80
        // Add automatic dimension which does the resizing.
        tableView.rowHeight = UITableViewAutomaticDimension
        
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
        
        // Listen for new message and refresh our screen.
        SocketService.instance.getChatMessage { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    
                    // Create variable to the last message in our message array.
                    let endInex = IndexPath.init(row: MessageService.instance.messages.count - 1, section: 0)
                    
                    // Set the TableView's position to that final spot
                    self.tableView.scrollToRow(at: endInex, at: .bottom, animated: false)
                }
            }
        }
        
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
            
            if success {
                // If there are new messages, reload data.
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    
    // Send Message Pressed Function
    @IBAction func sendMessagePressed(_ sender: Any) {
        
        // Make sure user is Logged in.
        if AuthService.instance.isLoggedIn {
            
            // Get channel ID and Text from UITextField
            guard let channelId = MessageService.instance.selectedChannel?.id else { return }
            guard let message = messageTextBox.text else { return }
            
            // Call Socket Function
            SocketService.instance.addMesage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId, completion: { (success) in
                if success {
                    
                    // Clear the message text box.
                    self.messageTextBox.text = ""
                    
                    // Dismiss the keyboard.
                    self.messageTextBox.resignFirstResponder()
                }
            })
        }
        
    }
    
    
    // Cell For Row At Function.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    // Number of Sections Function.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // Number of Rows in Section Function.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    
}

// ChatVC:  



















