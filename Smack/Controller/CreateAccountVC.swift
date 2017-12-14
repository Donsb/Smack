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
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    /*
     Instance Variables
     */
    
    var avatarName = "profileDefualt" // with a Default Name.
    var avatarColor = "[0.5, 0.5, 0.5, 1]" // String Array of the RGB aplha properties colour.
    var bgColor: UIColor? // Optional UIColor for Avatar color
    
    
    /*
     Functions
     */
    
    
    // View Did Load Function.
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    } // End View Did Load.
    
    
    // View Did Appear Function.  Updates Avatar once selected.
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            // Set the image once selected.
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            
            // Set the local avatar name for when creating an account.
            avatarName = UserDataService.instance.avatarName
            
            // Set a light grey bg color if avatar type is light.
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
            
        }
        
    } // End View Did Appear.
    
    
    // Did Receive Memory Warning Function.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // End Did Receive Memory Warning.
    
    
    // Close Pressed Action Function.
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    } // End Close Pressed.
    
    
    // Create Account Btn Pressed Function
        //-> Grab username and password.
    @IBAction func createAccountPressed(_ sender: Any) {
        
        // Activity indicator status
        spinner.isHidden = false // Show the Activity Indicator.
        spinner.startAnimating() // Make it spin.
        
        // Grab Username text.
        guard let name = userNameTxt.text, userNameTxt.text != "" else { return }
        
        // Grab email text.
        guard let email = emailTxt.text , emailTxt.text != "" else {return}
        
        // Grab Password text.
        guard let pass = passwordTxt.text , passwordTxt.text != "" else {return}
        
        // Call register Function from AuthService.  Pass it email and pass.
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true // Hide Activity Indicator
                                self.spinner.stopAnimating() // Stop Activity spinning.
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil) // Posts to all classes
                            }
                            
                        })
                        
                    }
                    
                })
                
            }
            
        }
        
    } // END Create Account Pressed.
    
    
    // Pick Avatar Btn Pressed Function
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    } // End Pick Avatar Pressed.
    
    
    // Pick Background Colour Btn Pressed Function.
    @IBAction func pickBGColourPressed(_ sender: Any) {
        
        // Randomly Generated Numbers for the R-G-B
        let r = CGFloat(arc4random_uniform(255)) / 255 // 1-255 divided by 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        // Set bcColor
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1) // 1 alpha, not transparent.
        avatarColor = "[\(r), \(g), \(b), 1]" // Set avatarColor to our chosen bg colour.
        
        UIView.animate(withDuration: 0.2) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    } // End Pick BG Color Pressed.
    
    
    // Set Up View
    func setUpView() {
        spinner.isHidden = true // Start with it hidden
        userNameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: SMACK_PURPLE_PLACEHOLDER])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap) // add to our view.
    } // End Set Up View.
    
    
    // Handle Tap Function
        // -> This will clear away keyboard if they click outside the keyboard.
    @objc func handleTap() {
        view.endEditing(true) // Causes the view to dismiss the keyboard.
    } // End Handle Tap.
    
    
} // End Class.





