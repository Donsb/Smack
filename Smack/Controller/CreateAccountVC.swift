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
     Instance Variables
     */
    
    var avatarName = "profileDefualt" // with a Default Name.
    var avatarColor = "[0.5, 0.5, 0.5, 1]" // String Array of the RGB aplha properties colour.
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // Update Avatar once selected.
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            // Set the image once selected.
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            
            // Set the local avatar name for when creating an account.
            avatarName = UserDataService.instance.avatarName
        }
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
        
        // Grab Username text.
        guard let name = userNameTxt.text, userNameTxt.text != "" else { return }
        
        // Grab email text.
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        
        // Grab Password text.
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
     // Call register Function from AuthService.  Pass it email and pass.
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                print("Success 1")
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("Success 2")
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    } // END Create Account Btn Pressed Function.
    
    
    // Log In User Function.
    func loginUser() {
        
    }
    
    
    // Pick Avatar Btn Pressed Function
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    
    // Pick Background Colour Btn Pressed Function.
    @IBAction func pickBGColourPressed(_ sender: Any) {
        
    }
    
    
}

// CreateAccountVC: 







