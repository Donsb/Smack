//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Donald Belliveau on 2017-12-06.
//  Copyright © 2017 Donald Belliveau. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    /*
     IBOutlets
     */
    
    @IBOutlet weak var userNameTxt: UITextField! // username Text Field
    @IBOutlet weak var emailTxt: UITextField! // Email Text Field
    @IBOutlet weak var passwordTxt: UITextField! // Password Text Field
    @IBOutlet weak var userImg: UIImageView! // Image View
    
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Close Pressed Action Function.
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    // Create Account Btn Pressed Function
        //-> Grab username and password.
    @IBAction func createAccountPressed(_ sender: Any) {
        // Grab email text.
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        
        // Grab Password text.
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
     // Call register Function from AuthService.  Pass it email and pass.
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("registered user!")
            }
        }
    }
    
    
    // Pick Avatar Btn Pressed Function
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    
    // Pick Background Colour Btn Pressed Function.
    @IBAction func pickBGColourPressed(_ sender: Any) {
        
    }
    
    
}

// CreateAccountVC: 
