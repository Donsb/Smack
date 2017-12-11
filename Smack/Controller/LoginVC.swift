//
//  LoginVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-06.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var userName: UITextField!  // Was supposed to be email not userName.
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Close Pressed IB Action Function
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Create Account IB Action Function.
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        // Show spinner and make it spin.
        spinner.isHidden = false
        spinner.startAnimating()
        
        // Verify email and Password aren't empty.
        guard let email = userName.text , userName.text != "" else { return }
        guard let password = passwordTxt.text , passwordTxt.text != "" else { return }
        
        // Send to Server
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                
                // Is log in was successful, call User By EMail Function to fill in our UserDataService Variables.
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        
                        // Send out Notification that user data changed.
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        
                        //Hide and stop spinner
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        
                        // Dismiss the screen once logged in.
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                })
            }
        }
        
    }
    
    
    //
    func setUpView() {
        
        // Hide Spinner to begin.
        spinner.isHidden = true
        
        // Set up our Placeholders for the text fields.
        userName.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        
    }
    
    
} // END class



// LoginVC:  

















