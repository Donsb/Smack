//
//  ProfileVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-11.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    /*
     Functions
     */
    
    
    
    // View Did Load Function
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // Did Receive Memory Warning Function
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Close Button Pressed Function.
    @IBAction func closeModelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // Logout Btn Pressed Function.
    @IBAction func logoutPressed(_ sender: Any) {
        
        // Call logoutUser function
        UserDataService.instance.logoutUser()
        
        // Adv Notification Data Changed
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        
        // Dissmiss the View.
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // Set Up View Function.
        //-> Set username / user emai / Profile image / Profile image colour.
    func setUpView() {
        userName.text = UserDataService.instance.name  // Set uerName
        userEmail.text = UserDataService.instance.email // set user email
        profileImage.image = UIImage(named: UserDataService.instance.avatarName) // set user profile avatar
        profileImage.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor) // set avatar colour.
        
        // Tap to dismiss the pop up.
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        
        // Add closeTouch to our bgView
        bgView.addGestureRecognizer(closeTouch)
    }
    
    
    
    // Close with Tap Function
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
} // END class.



// ProfileVC:  

