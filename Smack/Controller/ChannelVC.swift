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
     IBOutlets
     */
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    @IBOutlet weak var userImage: CircleImage!
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Make the Toggle of ChatVC smaller when toggled to the right; so we can see Channel VC more.
            // .width - 60 means we only want to see 60 points of the ChatVC when toggled.
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        // Observer
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
    }
    
    
    // View Did Appear.
    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
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
        }
    }
    
    
}

// ChannelVC:  














