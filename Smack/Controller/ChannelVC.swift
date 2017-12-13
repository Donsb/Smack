//
//  ChannelVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-05.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var tableView: UITableView!
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegate and DataSource to self.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Make the Toggle of ChatVC smaller when toggled to the right; so we can see Channel VC more.
            // .width - 60 means we only want to see 60 points of the ChatVC when toggled.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        // Observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.channelsLoaded(_:)), name: NOTIF_CHANNELS_LOADED, object: nil)
        
        //Check for new Channels
        SocketService.instance.getChannel { (success) in
            self.tableView.reloadData()
        }
    }
    
    
    // View Did Appear.
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }
    
    
    // Add Channel Pressed Function.
    @IBAction func addChannelPressed(_ sender: Any) {
        
        // Only can add a channel if logged in.
        if AuthService.instance.isLoggedIn {
            
            // Instantiate the addChannel
            let addChannel = AddChannelVC()
            
            // Set Presentation Style
            addChannel.modalPresentationStyle = .custom
            
            // Present it
            present(addChannel, animated: true, completion: nil)
        }
        
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Login Button Pressed Function.
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            
            // Show Profile page.
            let profile = ProfileVC()
            
            // set style-> model.
            profile.modalPresentationStyle = .custom
            
            // Present profile.
            present(profile, animated: true, completion: nil)
            
        } else {
            
        // Add segue to LoginVC
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
            
        }
        
    }
    
    
    // User Data Did Change Function.
    @objc func userDataDidChange(_ notif: Notification) {
        
        setupUserInfo()
        
    }
    
    
    // Channels Loaded Function.
    @objc func channelsLoaded(_ notif: Notification) {
        tableView.reloadData()
    }
    
    
    // Setup User Info Function
    func setupUserInfo() {
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal) // Change login to be userName.
            userImage.image = UIImage(named: UserDataService.instance.avatarName) // Change image to Avatar
            userImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor) // Set Background colour.
        } else {
            loginBtn.setTitle("Login", for: .normal) // Set title back to Login
            userImage.image = UIImage(named: "menuProfileIcon") // Set image back to menuProfileIcon
            userImage.backgroundColor = UIColor.clear // Set background colour to clear.
            tableView.reloadData()
        }
    }
    
    
    // Cell For Row At Function.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell {
            
            // Variable to pass into our TableViewCell.
            let channel = MessageService.instance.channels[indexPath.row]
            
            // Call Configure Cell Function, pass in our channel variable.
            cell.configureCell(channel: channel)
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    
    // Number Of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return MessageService.instance.channels.count
    }
    
    
    // Number Of Rows In Section Function
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    // Did Select Row At Function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let channel = MessageService.instance.channels[indexPath.row]
        MessageService.instance.selectedChannel = channel
        NotificationCenter.default.post(name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        // Make menu slide back in palce
        self.revealViewController().revealToggle(true)
    }

    
    
}

// ChannelVC:  














